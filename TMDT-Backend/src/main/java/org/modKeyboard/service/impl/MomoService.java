package org.modKeyboard.service.impl;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modKeyboard.dto.OrderDTO;
import org.modKeyboard.dto.request.MoMoCallback;
import org.modKeyboard.dto.request.MoMoRequest;
import org.modKeyboard.dto.response.MoMoQueryResponse;
import org.modKeyboard.dto.response.MoMoResponse;
import org.modKeyboard.service.IMomoService;
import org.modKeyboard.util.MoMoUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class MomoService implements IMomoService {
  @Value("${MOMO_PARTNER_CODE}")
  String partnerCode;

  @Value("${MOMO_ACCESS_KEY}")
  String accessKey;

  @Value("${MOMO_SECRET_KEY}")
  String secretKey;

  final MoMoUtil utils;

  @Override
  public String getPaymentUrl(OrderDTO order) {
    String requestId = UUID.randomUUID().toString();
    String orderId = order.getId().toString();
    String orderInfo = orderId;
    String extraData = "";
    String amount = String.valueOf((long) order.getTotalAmount());

    // generate params for signature
    Map<String, String> params = new TreeMap<>();
    params.put("accessKey", accessKey);
    params.put("amount", amount);
    params.put("extraData", extraData);
    params.put("ipnUrl", MoMoUtil.IPN_URL);
    params.put("orderId", orderId);
    params.put("orderInfo", orderInfo);
    params.put("partnerCode", partnerCode);
    params.put("redirectUrl", MoMoUtil.RETURN_URL);
    params.put("requestId", requestId);
    params.put("requestType", MoMoUtil.REQUEST_TYPE);

    // generate signature from params
    String signature = utils.generateSignature(secretKey, params);

    // create request object
    MoMoRequest momoRequest = MoMoRequest.builder()
        .partnerCode(partnerCode)
        .accessKey(accessKey)
        .requestId(requestId)
        .amount(amount)
        .orderId(orderId)
        .orderInfo(orderInfo)
        .redirectUrl(MoMoUtil.RETURN_URL)
        .ipnUrl(MoMoUtil.IPN_URL)
        .extraData(extraData)
        .requestType(MoMoUtil.REQUEST_TYPE)
        .signature(signature)
        .build();

    // send request to MoMo API
    MoMoResponse response = utils.sendRequest(MoMoUtil.MOMO_CREATE_ENDPOINT, momoRequest, MoMoResponse.class);
    if (MoMoUtil.SUCCESS_CODE != response.getResultCode()) {
      throw new RuntimeException("Failed to create MoMo payment: " + response.getMessage());
    }

    return response.getPayUrl();
  }

  @Override
  public boolean checkPaymentStatus(MoMoCallback callback) {
    // generate params for signature
    Map<String, String> params = new TreeMap<>();
    params.put("accessKey", accessKey);
    params.put("orderId", callback.getOrderId());
    params.put("partnerCode", partnerCode);
    params.put("requestId", callback.getRequestId());

    // generate signature from params
    String signature = utils.generateSignature(secretKey, params);
    System.out.println("Generated Signature for Status Check: " + signature);

    // create request object
    Map<String, String> requestBody = new TreeMap<>();
    requestBody.put("partnerCode", partnerCode);
    requestBody.put("accessKey", accessKey);
    requestBody.put("requestId", callback.getRequestId());
    requestBody.put("orderId", callback.getOrderId());
    requestBody.put("signature", signature);

    // send request to MoMo API
    MoMoQueryResponse response = utils.sendRequest(MoMoUtil.MOMO_QUERY_ENDPOINT, requestBody, MoMoQueryResponse.class);

    return MoMoUtil.SUCCESS_CODE == response.getResultCode();
  }

}
