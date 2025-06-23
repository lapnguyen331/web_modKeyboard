package org.modKeyboard.dto.response.order;

import java.util.UUID;

public record CustomerInfo(
    UUID id,
    String fullName,
    String phone,
    String email) {
}
