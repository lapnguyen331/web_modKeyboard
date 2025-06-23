package org.modKeyboard.dto.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
@FieldDefaults(level = AccessLevel.PRIVATE)
public class MoMoQueryResponse {
    String partnerCode;
    String orderId;
    String requestId;
    String extraData;
    long amount;
    long transId;
    String payType;
    int resultCode;
    String message;
    long responseTime;
    long lastUpdated;
    String signature;


}
