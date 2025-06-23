package org.modKeyboard.dto.request.order;

import org.modKeyboard.dto.enums.OrderStatus;

public record OrderUpdateRequest(
    OrderStatus status) {
}
