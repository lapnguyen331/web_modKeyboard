package org.modKeyboard.dto.response.payment;

import java.util.UUID;

import org.modKeyboard.dto.enums.PaymentMethod;
import org.modKeyboard.dto.enums.PaymentStatus;

public record PaymentResponse(
    UUID id,
    PaymentStatus paymentStatus,
    PaymentMethod paymentMethod

) {
}
