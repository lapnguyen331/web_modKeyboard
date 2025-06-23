package org.modKeyboard.dto.response;

import java.util.List;

public record ProductDetailResponse(
    ProductSummaryResponse product,
    String description,
    List<ImageResponse> images) {

}
