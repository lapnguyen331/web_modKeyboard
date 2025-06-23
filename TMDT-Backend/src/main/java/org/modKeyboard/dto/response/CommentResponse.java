package org.modKeyboard.dto.response;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public record CommentResponse(
    UUID id,
    UUID productId,
    Author author,
    String content,
    List<CommentResponse> replies,
    int depth,
    LocalDateTime createdAt

) {
  public record Author(UUID id, String fullName) {
  }
}
