package org.modKeyboard.service.impl;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.CartItemDTO;
import org.modKeyboard.dto.response.ProductSummaryResponse;
import org.modKeyboard.entity.Cart;
import org.modKeyboard.entity.CartItem;
import org.modKeyboard.entity.User;
import org.modKeyboard.eventlistner.event.CartEvent;
import org.modKeyboard.exception.ResourceNotFoundException;
import org.modKeyboard.mapper.CartMapper;
import org.modKeyboard.repository.CartItemRepository;
import org.modKeyboard.repository.CartRepository;
import org.modKeyboard.service.ICartService;
import org.modKeyboard.service.IProductService;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CartService implements ICartService {
  CartRepository cartRepository;
  CartItemRepository cartItemRepository;
  IProductService productService;
  CartMapper cartMapper;
  ApplicationEventPublisher eventPublisher;

  @Override
  public List<CartItemDTO> getCartByUser(UUID userId) {

    // Retrieve the cart items for the given user
    Sort sort = Sort.by("updatedAt").descending();
    List<CartItem> cartItems = cartItemRepository.findCartItemByUser(userId, sort);

    // Map the cart items to CartItemDTOs
    List<CartItemDTO> results = cartMapper.toItemDTOs(cartItems);

    return results;
  }

  @Override
  @Transactional
  public void deleteCart(UUID userId, UUID itemId) {
    // Find the cart item for the user and cart item ID
    CartItem cartItem = cartItemRepository.findById(itemId)
        .orElseThrow(() -> new ResourceNotFoundException("Cart item not found"));

    if (!cartItem.getCart().getUser().getId().equals(userId)) {
      throw new IllegalArgumentException("You do not have permission to delete this cart item");
    }

    // Delete the cart item
    cartItemRepository.delete(cartItem);
  }

  @Override
  @Transactional
  public CartItemDTO saveCart(UUID userId, UUID cartItemId, UUID productId, int quantity) {
    // Fetch product and validate
    ProductSummaryResponse product = productService.getProductById(productId);
    if (product == null) {
      throw new ResourceNotFoundException("Product not found");
    }
    if (product.quantity() == 0) {
      throw new IllegalArgumentException("Product is out of stock");
    }

    // Adjust quantity to not exceed stock
    final int finalQuantity = Math.min(quantity, product.quantity());

    if (cartItemId != null) {
      return updateExistingCartItem(userId, cartItemId, finalQuantity);
    } else {
      return createOrUpdateCartItem(userId, productId, finalQuantity);
    }
  }

  @Override
  @Transactional
  public void clearCart(UUID id) {
    // Find the cart for the user
    Cart cart = cartRepository.findByUserId(id)
        .orElseThrow(() -> new ResourceNotFoundException("Cart not found"));

    List<UUID> ids = cart.getCartItems().stream().map(CartItem::getId).toList();
    // Clear all items in the cart
    cartItemRepository.deleteAllById(ids);

    cart.setCartItems(null);
    cartRepository.save(cart);
  }

  @Override
  public int countTotalQuantities(UUID userId) {
    // Count the total quantities of items in the cart for the user
    return cartItemRepository.countTotalQuantities(userId).orElse(0);
  }

  private CartItemDTO updateExistingCartItem(UUID userId, UUID cartItemId, int quantity) {
    CartItem cartItem = cartItemRepository.findById(cartItemId)
        .orElseThrow(() -> new ResourceNotFoundException("Cart item not found"));

    if (!cartItem.getCart().getUser().getId().equals(userId)) {
      throw new IllegalArgumentException("You do not have permission to update this cart item");
    }

    updateItem(cartItem, userId, quantity);
    return cartMapper.toItemDTO(cartItem);
  }

  private CartItemDTO createOrUpdateCartItem(UUID userId, UUID productId, int quantity) {
    Cart cart = cartRepository.findByUserId(userId).orElseGet(() -> createNewCart(userId));

    CartItem cartItem = cartItemRepository.findItemByProduct(cart.getId(), productId).orElse(null);

    if (cartItem != null) {
      quantity = cartItem.getQuantity() + quantity;
      cartItem = updateItem(cartItem, userId, quantity);
    } else {
      cartItem = CartItem.builder()
          .cart(cart)
          .product(productService.findById(productId))
          .quantity(quantity)
          .build();

      cartItemRepository.saveAndFlush(cartItem);
      eventPublisher.publishEvent(new CartEvent(cart.getUser().getFullName(), userId));
    }

    return cartMapper.toItemDTO(cartItem);
  }

  private CartItem updateItem(CartItem cartItem, UUID userId, int quantity) {
    if (cartItem == null || cartItem.getCart() == null || cartItem.getCart().getUser() == null
        || !cartItem.getCart().getUser().getId().equals(userId)) {
      throw new IllegalArgumentException("You do not have permission to update this cart item");
    }

    if (cartItem.getQuantity() == quantity) {
      return cartItem;
    }

    cartItem.setQuantity(quantity);
    return cartItemRepository.save(cartItem);
  }

  private Cart createNewCart(UUID userId) {
    // Create a new Cart
    Cart cart = Cart.builder().user(new User(userId)).build();
    return cartRepository.save(cart);
  }
}
