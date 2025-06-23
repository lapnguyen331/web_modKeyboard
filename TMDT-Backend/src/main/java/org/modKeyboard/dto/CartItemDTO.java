package org.modKeyboard.dto;

import org.modKeyboard.dto.response.ProductSummaryResponse;

import java.util.UUID;

public record CartItemDTO(
    UUID id,
    ProductSummaryResponse product,
    int quantity) {
}
