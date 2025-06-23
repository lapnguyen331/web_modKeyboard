package org.modKeyboard.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;
import org.hibernate.validator.constraints.Range;

import java.util.UUID;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UpdateCartRequest {
    @NotNull(message = "Cart item ID cannot be null")
    UUID cartItemId;

    @NotNull(message = "Product ID cannot be null")
    UUID productId;

    @NotNull(message = "Quantity cannot be null")
    @Range(min = 1, max = 50, message = "Quantity must be greater than 0 and less than 50")
    Integer quantity;
}
