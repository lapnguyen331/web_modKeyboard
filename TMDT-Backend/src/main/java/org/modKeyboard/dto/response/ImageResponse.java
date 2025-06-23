package org.modKeyboard.dto.response;

import java.time.LocalDateTime;
import java.util.UUID;

public record ImageResponse(
    UUID id,
    String imagePath,
    LocalDateTime uploadedAt) {
}
