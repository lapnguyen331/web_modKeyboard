package org.modKeyboard.dto.request.product;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.UUID;

import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@EqualsAndHashCode(callSuper = true)
public class ProductUpdateRequest extends ProductCreateRequest {
  UUID id;
}
