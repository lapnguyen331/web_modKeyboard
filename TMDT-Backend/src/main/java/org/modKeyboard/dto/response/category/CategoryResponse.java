package org.modKeyboard.dto.response.category;

import java.sql.Timestamp;
import java.util.UUID;

public record CategoryResponse(
    UUID id,
    String name,
    boolean isDeleted,
    String description,
    Timestamp createdAt) {
}
