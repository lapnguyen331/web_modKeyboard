package org.modKeyboard.dto.response.rating;

import java.time.LocalDateTime;
import java.util.UUID;

import org.modKeyboard.dto.response.CommentResponse.Author;

public record RatingResponse(
    UUID id,
    Author author,
    String content,
    byte rating,
    LocalDateTime createdAt) {

}
