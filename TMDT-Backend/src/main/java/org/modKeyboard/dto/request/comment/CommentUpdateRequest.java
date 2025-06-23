package org.modKeyboard.dto.request.comment;

import jakarta.validation.constraints.NotBlank;

public record CommentUpdateRequest(@NotBlank String content) {
}
