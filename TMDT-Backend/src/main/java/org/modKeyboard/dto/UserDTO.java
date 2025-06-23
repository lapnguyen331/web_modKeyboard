package org.modKeyboard.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.modKeyboard.dto.enums.RoleEnum;

import java.util.List;
import java.util.UUID;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {
  private UUID id;

  private String email;

  @JsonIgnore
  private transient String password;

  private String fullName;

  private String phone;

  private String address;

  private boolean status;

    private List<RoleEnum> roles;
}
