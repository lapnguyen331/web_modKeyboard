package org.modKeyboard.service;


import org.modKeyboard.dto.GooglePojo;
import org.modKeyboard.dto.request.AuthenticationRequest;
import org.modKeyboard.dto.response.AuthResponse;
import org.modKeyboard.dto.response.JwtResponse;

public interface IAuthenticationService {
    AuthResponse login(AuthenticationRequest request);


    AuthResponse oauth2GoogleLogin(GooglePojo googlePojo);

    void logout(String jwtToken, String refreshToken);

    JwtResponse refreshToken(String refreshToken);
}
