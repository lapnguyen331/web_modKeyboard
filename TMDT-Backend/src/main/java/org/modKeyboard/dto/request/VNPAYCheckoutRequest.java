package org.modKeyboard.dto.request;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class VNPAYCheckoutRequest {
    String orderId;
    String vnpTransactionNo;
    String vnpResponseCode;
    String vnpSecureHash;
    String vnpTransactionStatus;
    String vnpTxnRef;
    String vnpAmount;
    String vnpBankCode;
    String vnpCardType;
    String vnpOrderInfo;
    String vnpBankTranNo;
    String vnpPayDate;
    String vnpTmnCode;
}
