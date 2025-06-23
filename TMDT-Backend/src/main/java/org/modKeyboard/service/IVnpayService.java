package org.modKeyboard.service;

import org.modKeyboard.dto.OrderDTO;

import java.util.Map;

public interface IVnpayService {
    String generatePaymentUrl(OrderDTO order, String ipAddress);

    boolean processPaymentResponse(Map<String, String> fields, String ipAddress);
}
