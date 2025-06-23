package org.modKeyboard.util;

import jakarta.servlet.http.HttpServletRequest;
import lombok.experimental.UtilityClass;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@UtilityClass
public class VnpayHelper {
    // Define VNPAY parameters
    public final String VNPAY_PAY_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public final String VNPAY_RETURN_URL = "http://localhost:5173/thanh-toan?payment=vnpay";
    public final String VNPAY_VERSION = "2.1.0";
    public final String VNPAY_COMMAND = "pay";
    public final String VNPAY_ORDER_TYPE = "other";
    public final String SUCCESS_CODE = "00";

    public Map<String, String> getParamsFromRequest(final HttpServletRequest request) {
        Map<String, String> fields = new HashMap<>();
        Enumeration<String> params = request.getParameterNames();

        // Decode the parameters from the request
        while (params.hasMoreElements()) {
            String fieldName = URLDecoder.decode(params.nextElement(), StandardCharsets.US_ASCII);
            String fieldValue = URLDecoder.decode(request.getParameter(fieldName), StandardCharsets.US_ASCII);
            if ((fieldValue != null) && (!fieldValue.isEmpty())) {
                fields.put(fieldName, fieldValue);
            }
        }
        return fields;
    }

    public String getIpAddress(final HttpServletRequest request) {
        String ipAdress;
        try {
            ipAdress = request.getHeader("X-FORWARDED-FOR");
            if (ipAdress == null) {
                ipAdress = request.getRemoteAddr();
            }
        } catch (Exception e) {
            ipAdress = "Invalid IP:" + e.getMessage();
        }
        return ipAdress;
    }

    public String getRandomNumber(int len) {
        Random rnd = new Random();
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }

    public Map<String, String> initParams() {
        Map<String, String> params = new HashMap<>();
        params.put("vnp_Version", VNPAY_VERSION);
        params.put("vnp_Command", VNPAY_COMMAND);
        params.put("vnp_CurrCode", "VND");
//        params.put("vnp_BankCode", "");

        // Generate a random transaction reference number
        final String VNP_TXN_REF = VnpayHelper.getRandomNumber(8);
        params.put("vnp_TxnRef", getRandomNumber(8));
        params.put("vnp_OrderInfo", "Thanh toan don hang:" + VNP_TXN_REF);
        params.put("vnp_OrderType", VnpayHelper.VNPAY_ORDER_TYPE);
        params.put("vnp_Locale", "vn");

        // Get the current date and time in the GMT+7 timezone
        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        params.put("vnp_CreateDate", formatter.format(cld.getTime()));

        // Add 15 minutes to the current time to get the expiry date
        cld.add(Calendar.MINUTE, 15);
        params.put("vnp_ExpireDate", formatter.format(cld.getTime()));

        return params;
    }

    public Map<String, String> buildQuery(Map<String, String> params) {
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);

        StringBuilder hashData = new StringBuilder();

        StringBuilder query = new StringBuilder();

        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = params.get(fieldName);
            if ((fieldValue != null) && (!fieldValue.isEmpty())) {
                // Build the hash data and query string
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));

                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));

                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        return Map.of(
                "hashData", hashData.toString(),
                "query", query.toString()
        );
    }
}
