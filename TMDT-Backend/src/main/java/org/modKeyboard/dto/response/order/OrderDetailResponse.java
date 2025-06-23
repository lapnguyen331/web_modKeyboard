package org.modKeyboard.dto.response.order;

import java.sql.Timestamp;
import java.util.List;

public record OrderDetailResponse(
    OrderSummaryResponse orderSummary,
    List<OrderItemSummary> orderItems,
    CustomerInfo customerInfo,
    String street,
    String note,
    String address,
    String recipient,
    Timestamp createdAt) {

}
