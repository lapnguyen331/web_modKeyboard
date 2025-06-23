package org.modKeyboard.service;


import org.modKeyboard.dto.CartItemDTO;

import java.util.List;
import java.util.UUID;

public interface ICartService {

    List<CartItemDTO> getCartByUser(UUID userId);

    void deleteCart(UUID userId, UUID itemId);

    CartItemDTO saveCart(UUID userId, UUID cartItemId, UUID productId, int quantity);

    void clearCart(UUID userId);

    int countTotalQuantities(UUID userId);
}
