package org.modKeyboard.dto.request.comment;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

public record CommentCreateRequest(@NotBlank String content, @NotNull UUID productId) {
}
