package org.modKeyboard.dto.response;

import org.modKeyboard.dto.response.category.CategoryResponse;
import java.util.UUID;

public record ProductSummaryResponse(
    UUID id,
    CategoryResponse category,
    String name,
    int totalViews,
    String volume,
    String thumbnail,
    double price,
    double discountPrice,
    int quantity,
    double rating,
    int sold) {
}
