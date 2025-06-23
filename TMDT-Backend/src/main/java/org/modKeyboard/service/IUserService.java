package org.modKeyboard.service;


import org.modKeyboard.dto.GooglePojo;
import org.modKeyboard.dto.UserDTO;
import org.modKeyboard.dto.request.RegistrationRequest;

import java.util.UUID;

public interface IUserService {
    UserDTO getUserById(UUID id);

    UserDTO getByEmail(String email);

    UserDTO createUser(GooglePojo googlePojo);

    boolean isEmailExists(String email);

    String generateForgotPasswordOTP(String email);

    UserDTO forgotPassword(String otp);

    UserDTO registerUser(RegistrationRequest request);
    UserDTO verifyEmail(String otp);



}
