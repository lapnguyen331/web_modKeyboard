package org.modKeyboard.dto.response.order;

import java.sql.Timestamp;
import java.util.UUID;

import org.modKeyboard.dto.enums.OrderStatus;
import org.modKeyboard.dto.response.payment.PaymentResponse;

public record OrderSummaryResponse(
    UUID id,
    String customerName,
    String phoneNumber,
    Double totalAmount,
    OrderStatus status,
    PaymentResponse payment,
    Timestamp createdAt) {
}
