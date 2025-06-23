package org.modKeyboard.dto.response.order;

import org.modKeyboard.dto.response.ProductSummaryResponse;

public record OrderItemSummary(
    Double price,
    Integer quantity,
    ProductSummaryResponse product
) {
}
