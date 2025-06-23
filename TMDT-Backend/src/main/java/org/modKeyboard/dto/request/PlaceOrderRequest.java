package org.modKeyboard.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PlaceOrderRequest {

    @NotBlank
    String fullName;

    @NotBlank
    String phoneNumber;

    @NotBlank
    String street;

    @NotBlank
    String province;

    @NotBlank
    String district;

    @NotBlank
    String commune;

    String note;

    @NotBlank
    String paymentMethod;

}
