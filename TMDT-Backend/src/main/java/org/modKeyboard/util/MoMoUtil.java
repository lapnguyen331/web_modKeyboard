package org.modKeyboard.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.TreeMap;

@Component
@RequiredArgsConstructor
public class MoMoUtil {
    public static final String MOMO_CREATE_ENDPOINT = "https://test-payment.momo.vn/v2/gateway/api/create";
    public static final String MOMO_QUERY_ENDPOINT = "https://test-payment.momo.vn/v2/gateway/api/query";
    public static final String RETURN_URL = "http://localhost:5173/thanh-toan?payment=momo";
    public static final String IPN_URL = "http://localhost:8182/api/v1/orders/momo-payment/payment-completed";
    public static final String REQUEST_TYPE = "payWithMethod";
    //    public static final String REQUEST_TYPE = "captureWallet";
//    public static final String REQUEST_TYPE = "payWithATM";
    public static final int SUCCESS_CODE = 0;

    private final ObjectMapper objectMapper;

    public String generateSignature(String secretKey, Map<String, String> params) {
        StringBuilder rawSignature = new StringBuilder();
        for (Map.Entry<String, String> entry : new TreeMap<>(params).entrySet()) {
            rawSignature.append(entry.getKey()).append("=").append(entry.getValue()).append("&");
        }
        String data = rawSignature.substring(0, rawSignature.length() - 1);
        return HmacUtil.hmacSHA256(secretKey, data);
    }

    public <T> T sendRequest(String endpoint, Object request, Class<T> responseType) {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            // Create an HTTP POST request with the specified endpoint
            HttpPost httpPost = new HttpPost(endpoint);
            // Set the content type header to application/json
            httpPost.setHeader("Content-Type", "application/json");

            // Convert the request object to a JSON string using ObjectMapper
            String requestJson = objectMapper.writeValueAsString(request);
            // Set the request entity with the JSON string and UTF-8 encoding
            httpPost.setEntity(new StringEntity(requestJson, StandardCharsets.UTF_8));

            try (CloseableHttpResponse response = httpClient.execute(httpPost)) {
                // Read the response entity as a string using EntityUtils
                String jsonResponse = EntityUtils.toString(response.getEntity(), StandardCharsets.UTF_8);
                System.out.println("Response from MoMo: " + jsonResponse);
                return objectMapper.readValue(jsonResponse, responseType);
            }
        } catch (Exception e) {
            // Throw a runtime exception with the error message if an exception occurs during the request
            throw new RuntimeException("Error while sending request to MoMo: " + e.getMessage(), e);
        }
    }
}
