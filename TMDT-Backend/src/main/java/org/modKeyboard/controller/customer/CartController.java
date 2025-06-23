package org.modKeyboard.controller.customer;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modKeyboard.dto.CartItemDTO;
import org.modKeyboard.dto.CustomUserSecurity;
import org.modKeyboard.dto.request.AddCartRequest;
import org.modKeyboard.dto.request.UpdateCartRequest;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.service.ICartService;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@Validated
@RequestMapping("${API_PREFIX}/cart")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class CartController {
  ICartService cartService;

  @GetMapping({ "", "/" })
  public ResponseObject<List<CartItemDTO>> getCart(@AuthenticationPrincipal CustomUserSecurity user) {
    List<CartItemDTO> productList = cartService.getCartByUser(user.getId());
    return new ResponseObject<>(HttpStatus.OK, productList);
  }

  @GetMapping("/count")
  public ResponseObject<Integer> countTotalQuantities(@AuthenticationPrincipal CustomUserSecurity user) {
    int quantities = cartService.countTotalQuantities(user.getId());
    return new ResponseObject<>(HttpStatus.OK, quantities);
  }

  @PostMapping({ "", "/" })
  public ResponseObject<CartItemDTO> addCart(@AuthenticationPrincipal CustomUserSecurity user,
      @RequestBody @Valid AddCartRequest request) {
    CartItemDTO item = cartService.saveCart(user.getId(), null, request.getProductId(), request.getQuantity());
    return new ResponseObject<>(HttpStatus.OK, "Add product to cart successfully", item);
  }

  @PutMapping({ "", "/" })
  public ResponseObject<CartItemDTO> updateCart(@AuthenticationPrincipal CustomUserSecurity user,
      @RequestBody @Valid UpdateCartRequest request) {
    CartItemDTO item = cartService.saveCart(user.getId(), request.getCartItemId(), request.getProductId(),
        request.getQuantity());
    return new ResponseObject<>(HttpStatus.OK, "Update product in cart successfully", item);
  }

  @DeleteMapping("/{itemId}")
  public ResponseObject<Void> deleteCart(@AuthenticationPrincipal CustomUserSecurity user,
      @PathVariable("itemId") @NotNull UUID itemId) {
    cartService.deleteCart(user.getId(), itemId);
    return new ResponseObject<>(HttpStatus.OK, "Delete product from cart successfully");
  }

  @DeleteMapping("/")
  public ResponseObject<Void> clearCart(@AuthenticationPrincipal CustomUserSecurity user) {
    cartService.clearCart(user.getId());
    return new ResponseObject<>(HttpStatus.OK, "Clear cart successfully");
  }

}
