package org.modKeyboard.mapper;

import org.modKeyboard.dto.CartItemDTO;
import org.modKeyboard.entity.CartItem;
import org.springframework.stereotype.Component;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Component
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class CartMapper {
  ProductMapper productMapper;

  public CartItemDTO toItemDTO(CartItem item) {
    var product = productMapper.toProductSummary(item.getProduct());
    return new CartItemDTO(
        item.getId(),
        product,
        item.getQuantity());
  }

  public List<CartItemDTO> toItemDTOs(List<CartItem> items) {
    return items.stream().map(this::toItemDTO).toList();
  }
}
