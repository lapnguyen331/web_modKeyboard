package org.modKeyboard.dto.request.product;

import java.util.List;
import java.util.UUID;

public record ProductImagesUpdateRequest(
    UUID productId,
    String thumbnail,
    List<String> imageIds) {
}
