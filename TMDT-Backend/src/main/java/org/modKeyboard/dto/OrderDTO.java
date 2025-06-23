
package org.modKeyboard.dto;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.util.UUID;

@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderDTO {
    UUID id;
    String fullName;
    String phoneNumber;
    String street;
    String province;
    String district;
    String commune;
    String note;
    double totalAmount;
}
