package org.modKeyboard.dto.request.category;

public record CategoryUpdateRequest(
    String name,
    String description,
    boolean isDeleted
) {

}
