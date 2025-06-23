package org.modKeyboard.mapper;

import org.modKeyboard.dto.response.payment.PaymentResponse;
import org.springframework.stereotype.Component;
import org.modKeyboard.entity.Payment;

@Component
public class PaymentMapper {
  public PaymentResponse toResponse(Payment payment) {
    return new PaymentResponse(
        payment.getId(),
        payment.getStatus(),
        payment.getMethod());
  }

}
