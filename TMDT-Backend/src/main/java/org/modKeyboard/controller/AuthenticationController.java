//package org.modKeyboard.controller;
//
//import jakarta.servlet.http.Cookie;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.validation.Valid;
//import jakarta.validation.constraints.NotBlank;
//import lombok.AccessLevel;
//import lombok.RequiredArgsConstructor;
//import lombok.experimental.FieldDefaults;
//import lombok.extern.slf4j.Slf4j;
//import org.modKeyboard.dto.request.AuthenticationRequest;
//import org.modKeyboard.dto.request.TokenRequest;
//import org.modKeyboard.dto.response.AuthResponse;
//import org.modKeyboard.dto.response.JwtResponse;
//import org.modKeyboard.dto.response.ResponseObject;
//import org.modKeyboard.mapper.UserMapper;
//import org.modKeyboard.service.IAuthenticationService;
//import org.modKeyboard.util.CookieUtil;
//import org.modKeyboard.util.SystemConstant;
//import org.springframework.http.HttpStatus;
//import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
//import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
//import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
//import org.springframework.security.oauth2.core.OAuth2AccessToken;
//import org.springframework.security.oauth2.core.user.OAuth2User;
//import org.springframework.validation.annotation.Validated;
//import org.springframework.web.bind.annotation.*;
//
//
//@RestController
//@RequiredArgsConstructor
//@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
//@RequestMapping("${API_PREFIX}/auth")
//@Validated
//@Slf4j
//public class AuthenticationController {
//    IAuthenticationService authenticationService;
//
//   ClientRegistrationRepository clientRegistrationRepository;
//    UserMapper userMapper;
//
//    private void setCookie(HttpServletResponse response, String refreshToken) {
//        // Set refresh token in HTTP-Only cookie
//        Cookie refreshTokenCookie = CookieUtil.createCookie(SystemConstant.REFRESH_TOKEN, refreshToken,
//                "localhost", 604800, true, false);
//        response.addCookie(refreshTokenCookie);
//    }
//
//    @PostMapping("/google")
//    public ResponseObject<AuthResponse> google(@RequestBody @Valid TokenRequest request, HttpServletResponse response) {
//        DefaultOAuth2UserService oAuth2Service = new DefaultOAuth2UserService();
//        OAuth2UserRequest userRequest = new OAuth2UserRequest(clientRegistrationRepository.findByRegistrationId("google"),
//                new OAuth2AccessToken(OAuth2AccessToken.TokenType.BEARER, request.getToken(), null, null, null));
//        OAuth2User user = oAuth2Service.loadUser(userRequest);
//        AuthResponse resp = authenticationService.oauth2GoogleLogin(userMapper.toGooglePojo(user));
//        setCookie(response, resp.getRefreshToken());
//        return new ResponseObject<>(HttpStatus.OK,"Login successfully", resp);
//    }
//
//    @PostMapping("/login")
//    public ResponseObject<AuthResponse> authenticate(@RequestBody @Valid AuthenticationRequest request, HttpServletResponse response) {
//        AuthResponse resp = authenticationService.login(request);
//        setCookie(response, resp.getRefreshToken());
//        return new ResponseObject<>(HttpStatus.OK,"Login successfully", resp);
//
//    }
//
//
//    @PostMapping("/logout")
//    public ResponseObject<Void> logout(@RequestHeader("Authorization") String authHeader,
//                                       @CookieValue(SystemConstant.REFRESH_TOKEN) @NotBlank String refreshToken,
//                                       HttpServletResponse response
//    ) {
//        String jwtToken = authHeader.substring("Bearer ".length());
//        authenticationService.logout(jwtToken, refreshToken);
//        // clear refresh token cookie
//        Cookie refreshTokenCookie = CookieUtil.createCookie(SystemConstant.REFRESH_TOKEN, null, "localhost",
//                0, true, false);
//        response.addCookie(refreshTokenCookie);
//        return new ResponseObject<>(HttpStatus.OK, "Logout successfully", null);
//    }
//
//    @PostMapping("/refresh-token")
//    public ResponseObject<JwtResponse> refreshToken(
//            @CookieValue(SystemConstant.REFRESH_TOKEN) @NotBlank String refreshToken,
//            HttpServletResponse response) {
//        JwtResponse jwtObj = authenticationService.refreshToken(refreshToken);
//        setCookie(response, jwtObj.getRefreshToken());
//        return new ResponseObject<>(HttpStatus.OK, "Refresh token successfully", jwtObj);
//    }
//
//}


package org.modKeyboard.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.modKeyboard.dto.request.AuthenticationRequest;
import org.modKeyboard.dto.request.TokenRequest;
import org.modKeyboard.dto.response.AuthResponse;
import org.modKeyboard.dto.response.JwtResponse;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.mapper.UserMapper;
import org.modKeyboard.service.IAuthenticationService;
import org.modKeyboard.util.CookieUtil;
import org.modKeyboard.util.SystemConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.lang.Nullable;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AccessToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@FieldDefaults(level = AccessLevel.PRIVATE)
@RequestMapping("${API_PREFIX}/auth")
@Validated
@Slf4j
public class AuthenticationController {

    final IAuthenticationService authenticationService;
    final UserMapper userMapper;

    @Nullable
    final ClientRegistrationRepository clientRegistrationRepository;

    @Autowired
    public AuthenticationController(
            IAuthenticationService authenticationService,
            UserMapper userMapper,
            @Autowired(required = false) ClientRegistrationRepository clientRegistrationRepository
    ) {
        this.authenticationService = authenticationService;
        this.userMapper = userMapper;
        this.clientRegistrationRepository = clientRegistrationRepository;
    }

    private void setCookie(HttpServletResponse response, String refreshToken) {
        Cookie refreshTokenCookie = CookieUtil.createCookie(SystemConstant.REFRESH_TOKEN, refreshToken,
                "localhost", 604800, true, false);
        response.addCookie(refreshTokenCookie);
    }

    @PostMapping("/google")
    public ResponseObject<AuthResponse> google(@RequestBody @Valid TokenRequest request, HttpServletResponse response) {
        if (clientRegistrationRepository == null) {
            return new ResponseObject<>(HttpStatus.SERVICE_UNAVAILABLE, "Google OAuth not configured", null);
        }

        ClientRegistration registration = clientRegistrationRepository.findByRegistrationId("google");
        if (registration == null) {
            return new ResponseObject<>(HttpStatus.SERVICE_UNAVAILABLE, "Google client registration not found", null);
        }

        DefaultOAuth2UserService oAuth2Service = new DefaultOAuth2UserService();
        OAuth2UserRequest userRequest = new OAuth2UserRequest(
                registration,
                new OAuth2AccessToken(OAuth2AccessToken.TokenType.BEARER, request.getToken(), null, null, null)
        );
        OAuth2User user = oAuth2Service.loadUser(userRequest);
        AuthResponse resp = authenticationService.oauth2GoogleLogin(userMapper.toGooglePojo(user));
        setCookie(response, resp.getRefreshToken());
        return new ResponseObject<>(HttpStatus.OK, "Login successfully", resp);
    }

    @PostMapping("/login")
    public ResponseObject<AuthResponse> authenticate(@RequestBody @Valid AuthenticationRequest request, HttpServletResponse response) {
        AuthResponse resp = authenticationService.login(request);
        setCookie(response, resp.getRefreshToken());
        return new ResponseObject<>(HttpStatus.OK, "Login successfully", resp);
    }

    @PostMapping("/logout")
    public ResponseObject<Void> logout(
            @RequestHeader("Authorization") String authHeader,
            @CookieValue(SystemConstant.REFRESH_TOKEN) @NotBlank String refreshToken,
            HttpServletResponse response) {

        String jwtToken = authHeader.substring("Bearer ".length());
        authenticationService.logout(jwtToken, refreshToken);

        Cookie refreshTokenCookie = CookieUtil.createCookie(SystemConstant.REFRESH_TOKEN, null, "localhost", 0, true, false);
        response.addCookie(refreshTokenCookie);
        return new ResponseObject<>(HttpStatus.OK, "Logout successfully", null);
    }

    @PostMapping("/refresh-token")
    public ResponseObject<JwtResponse> refreshToken(
            @CookieValue(SystemConstant.REFRESH_TOKEN) @NotBlank String refreshToken,
            HttpServletResponse response) {

        JwtResponse jwtObj = authenticationService.refreshToken(refreshToken);
        setCookie(response, jwtObj.getRefreshToken());
        return new ResponseObject<>(HttpStatus.OK, "Refresh token successfully", jwtObj);
    }
}
