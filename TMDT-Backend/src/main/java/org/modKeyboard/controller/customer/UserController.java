package org.modKeyboard.controller.customer;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modKeyboard.dto.CustomUserSecurity;
import org.modKeyboard.dto.UserDTO;
import org.modKeyboard.dto.request.EmailRequest;
import org.modKeyboard.dto.request.OtpRequest;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.exception.ResourceNotFoundException;
import org.modKeyboard.service.IEmailService;
import org.modKeyboard.service.IUserService;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("${API_PREFIX}/users")
@Validated
public class UserController {
    IUserService userService;
    IEmailService emailService;

    @GetMapping("/me")
    public ResponseObject<UserDTO> getCurrentUser(@AuthenticationPrincipal CustomUserSecurity user) {
        return new ResponseObject<>(HttpStatus.OK, userService.getUserById(user.getId()));
    }

    @PostMapping("/forgot-password-opt")
    public ResponseObject<Void> forgotPassOtp(@RequestBody @Valid EmailRequest request) {
        boolean isExists = userService.isEmailExists(request.getEmail());
        if (!isExists) {
            throw new ResourceNotFoundException("Email not found");
        }
        String otp = userService.generateForgotPasswordOTP(request.getEmail());
        emailService.sendForgotPasswordOTP(request.getEmail(), otp);
        return new ResponseObject<>(HttpStatus.OK, null);
    }

    @PostMapping("/forgot-password")
    public ResponseObject<Void> forgotPass(@RequestBody @Valid OtpRequest request) {
        UserDTO user = userService.forgotPassword(request.getOtp());
        emailService.sendForgotPassword(user.getEmail(), user.getPassword());
        return new ResponseObject<>(HttpStatus.OK, null);
    }

}
