package org.modKeyboard.controller.customer;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.modKeyboard.dto.UserDTO;
import org.modKeyboard.dto.request.RegistrationRequest;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.service.IUserService;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("${API_PREFIX}/registration")
@Validated
@Slf4j
public class RegistrationController {

  IUserService userService;

  @PostMapping
  public ResponseObject<UserDTO> register(@RequestBody @Valid RegistrationRequest request) {
    UserDTO user = userService.registerUser(request);
    return new ResponseObject<>(HttpStatus.CREATED, "Đăng ký thành công! Vui lòng kiểm tra email để xác thực tài khoản",
        user);
  }

  @PostMapping("/verify")
  public ResponseObject<UserDTO> verifyEmail(@RequestParam String otp) {
    UserDTO user = userService.verifyEmail(otp);
    return new ResponseObject<>(HttpStatus.OK, "Xác thực email thành công!", user);
  }

  @GetMapping("/check-email")
  public ResponseObject<Boolean> checkEmailExists(@RequestParam String email) {
    boolean exists = userService.isEmailExists(email);
    return new ResponseObject<>(HttpStatus.OK,
        exists ? "Email đã tồn tại trong hệ thống" : "Email có thể sử dụng",
        exists);
  }

}
