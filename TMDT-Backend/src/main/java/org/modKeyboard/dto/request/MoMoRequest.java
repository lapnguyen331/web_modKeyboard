package org.modKeyboard.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

import java.io.Serializable;

@Data
@Builder
public class MoMoRequest implements Serializable {
    @JsonProperty("partnerCode")
    private String partnerCode;

    @JsonProperty("accessKey")
    private String accessKey;

    @JsonProperty("requestId")
    private String requestId;

    @JsonProperty("amount")
    private String amount;

    @JsonProperty("orderId")
    private String orderId;

    @JsonProperty("orderInfo")
    private String orderInfo;

    @JsonProperty("redirectUrl")
    private String redirectUrl;

    @JsonProperty("ipnUrl")
    private String ipnUrl;

    @JsonProperty("extraData")
    private String extraData;

    @JsonProperty("requestType")
    private String requestType;

    @JsonProperty("signature")
    private String signature;

    @JsonProperty("lang")
    private String lang;
}