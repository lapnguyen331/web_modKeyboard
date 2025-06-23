package org.modKeyboard.dto.request.product;

import lombok.Data;

import java.util.List;
import java.util.UUID;

import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductCreateRequest {
  String name;
  UUID categoryId;
  String description;
  Integer status;
  String volume;
  String thumbnail;
  List<String> imageIds;
  Double price;
  Double discountPrice;
  Integer quantity;
}
