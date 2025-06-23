package org.modKeyboard.service.impl;


import com.google.gson.JsonObject;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.modKeyboard.dto.OrderDTO;
import org.modKeyboard.exception.ResourceNotFoundException;
import org.modKeyboard.localCache.PaymentCache;
import org.modKeyboard.service.IVnpayService;
import org.modKeyboard.util.HmacUtil;
import org.modKeyboard.util.VnpayHelper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE)
public class VnpayService implements IVnpayService {
    final PaymentCache paymentCache;

    @Value("${VNP_TMN_CODE}")
    String vnpTmnCode;

    @Value("${VNP_SECRET_KEY}")
    String secretKey;


    /**
     * Generates a VNPAY payment URL for the given order.
     */
    @Override
    public String generatePaymentUrl(OrderDTO order, String ipAddress) {
        // Calculate the total price in VND (multiplied by 100 to convert to cents )
        long amount = (long) order.getTotalAmount() * 100;

        // Initialize a map to hold the VNPAY parameters
        Map<String, String> params = VnpayHelper.initParams();
        params.put("vnp_TmnCode", vnpTmnCode);
        params.put("vnp_Amount", String.valueOf(amount));
        params.put("vnp_ReturnUrl", VnpayHelper.VNPAY_RETURN_URL + "&orderId=" + order.getId());
        params.put("vnp_IpAddr", ipAddress);

        Map<String, String> query = VnpayHelper.buildQuery(params);

        // Generate the secure hash
        String queryUrl = query.get("query");
        final String VNPAY_SECURE_HASH = HmacUtil.hmacSHA512(secretKey, query.get("hashData"));
        queryUrl += "&vnp_SecureHash=" + VNPAY_SECURE_HASH;

        JsonObject json = new JsonObject();
        json.addProperty("vnp_CreateDate", params.get("vnp_CreateDate"));
        json.addProperty("vnp_ExpireDate", params.get("vnp_ExpireDate"));
        json.addProperty("vnp_SecureHash", VNPAY_SECURE_HASH);
        paymentCache.put(order.getId().toString(), json);

        // Build the payment URL
        String paymentUrl = VnpayHelper.VNPAY_PAY_URL + "?" + queryUrl;

        return paymentUrl;
    }


    /**
     * Processes the VNPAY response to verify the payment transaction.
     */
    @Override
    public boolean processPaymentResponse(Map<String, String> fields, String ipAddress) {
        String orderId = fields.get("orderId");

        boolean isValidResponse = isValidResponseCo(fields);
        if (!isValidResponse) {
            paymentCache.invalidate(orderId);
            return false;
        }

        // get cache data
        JsonObject valueCache = paymentCache.get(orderId);
        long createDate = valueCache.get("vnp_CreateDate").getAsLong();
        long expireDate = valueCache.get("vnp_ExpireDate").getAsLong();

        // Remove unnecessary keys from the fields map
        removeKeys(fields);

        // Regenerate parameters for secure hash calculation
        Map<String, String> params = regenerateParams(fields, orderId, ipAddress, createDate, expireDate);

        // Generate hashData and secure hash from all parameters
        Map<String, String> query = VnpayHelper.buildQuery(params);
        String generatedSecureHash = HmacUtil.hmacSHA512(secretKey, query.get("hashData"));

        // Verify secure hash and clear cache if valid
        if (generatedSecureHash.equals(valueCache.get("vnp_SecureHash").getAsString())) {
            // remove cache data
            paymentCache.invalidate(orderId);
            return true;
        } else {
            return false;
        }
    }

    private boolean isValidResponseCo(Map<String, String> fields) {
        // Validate response code
        String statusResponse = fields.get("vnp_ResponseCode");
        if (statusResponse == null || statusResponse.isEmpty() || !VnpayHelper.SUCCESS_CODE.equals(statusResponse)) {
            throw new IllegalArgumentException("Invalid response code");
        }

        // Verify cache data for orderId
        String orderId = fields.get("orderId");
        JsonObject valueCache = paymentCache.get(orderId);
        if (valueCache == null) {
            throw new ResourceNotFoundException("Payment cache not found for order ID: " + orderId);
        }

        // Validate transaction time
        long createDate = valueCache.get("vnp_CreateDate").getAsLong();
        long expireDate = valueCache.get("vnp_ExpireDate").getAsLong();
        long payDate = Long.parseLong(fields.get("vnp_PayDate"));
        if (payDate < createDate || payDate > expireDate) {
            return false;
        }

        return true;
    }

    private Map<String, String> regenerateParams(Map<String, String> fields, String orderId, String ipAddress, long createDate, long expireDate) {
        // Initialize a map to hold the VNPAY parameters
        Map<String, String> params = VnpayHelper.initParams();
        params.putAll(fields);
        params.put("vnp_IpAddr", ipAddress);
        params.put("vnp_CreateDate", createDate + "");
        params.put("vnp_ExpireDate", expireDate + "");
        params.put("vnp_ReturnUrl", VnpayHelper.VNPAY_RETURN_URL + "&orderId=" + orderId);

        return params;
    }

    private void removeKeys(Map<String, String> fields) {
        fields.remove("vnp_SecureHashType");
        fields.remove("vnp_SecureHash");
        fields.remove("orderId");
        fields.remove("vnp_TransactionNo");
        fields.remove("vnp_CardType");
        fields.remove("vnp_BankTranNo");
        fields.remove("vnp_ResponseCode");
        fields.remove("vnp_TransactionStatus");
        fields.remove("vnp_PayDate");
        fields.remove("vnp_BankCode");
        fields.remove("payment");
    }
}
