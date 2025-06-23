package org.modKeyboard.dto.request.rating;

import java.util.UUID;

public record RatingCreateRequest(
    UUID productId,
    String content,
    byte rating) {

}
