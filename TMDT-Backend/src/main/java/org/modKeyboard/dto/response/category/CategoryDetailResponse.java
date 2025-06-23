package org.modKeyboard.dto.response.category;

import java.sql.Timestamp;
import java.util.UUID;

public record CategoryDetailResponse(
    UUID id,
    String name,
    boolean isDeleted,
    String description,
    Timestamp createdAt,
    long productCount,
    long soldCount) {
}
