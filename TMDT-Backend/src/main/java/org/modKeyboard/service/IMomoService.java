package org.modKeyboard.service;

import org.modKeyboard.dto.OrderDTO;
import org.modKeyboard.dto.request.MoMoCallback;

public interface IMomoService {
    String getPaymentUrl(OrderDTO order);

    boolean checkPaymentStatus(MoMoCallback callback);
}
