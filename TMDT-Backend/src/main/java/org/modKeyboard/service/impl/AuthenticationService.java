package org.modKeyboard.service.impl;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.modKeyboard.dto.CustomUserSecurity;
import org.modKeyboard.dto.GooglePojo;
import org.modKeyboard.dto.UserDTO;
import org.modKeyboard.dto.request.AuthenticationRequest;
import org.modKeyboard.dto.response.AuthResponse;
import org.modKeyboard.dto.response.JwtResponse;
import org.modKeyboard.exception.UserNotFoundException;
import org.modKeyboard.service.IAuthenticationService;
import org.modKeyboard.service.IKeyService;
import org.modKeyboard.service.ITokenService;
import org.modKeyboard.service.IUserService;
import org.modKeyboard.util.JwtHelper;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.security.KeyPair;
import java.security.PrivateKey;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationService implements IAuthenticationService {
    AuthenticationManager authenticationManager;
    ITokenService tokenService;
    JwtService jwtService;
    JwtHelper jwtHelper;
    UserDetailServiceImpl userDetailsService;
    IKeyService keyService;
    IUserService userService;

    // Method to handle common logic for generating JWT response
    // Generates a JWT response containing access and refresh tokens
    private JwtResponse generateJwtResponse(String email, PrivateKey privateKey) throws InterruptedException, ExecutionException {
        // Generate access token asynchronously
        CompletableFuture<String> accessToken = jwtService.generateAccessToken(email, privateKey);
        // Generate refresh token asynchronously
        CompletableFuture<String> refreshToken = jwtService.generateRefreshToken(email, privateKey);
        // Wait for both tokens to be generated
        CompletableFuture.allOf(accessToken, refreshToken).join();
        // Return the JWT response with the generated tokens and public key
        return new JwtResponse(accessToken.get(), refreshToken.get());
    }

    // Creates a JWT response for a given email and user ID
    private AuthResponse createResponse(String email, UUID userId) {
        // Retrieve the key pair associated with the user
        java.security.KeyPair keyPair = keyService.getKeyPairByUser(userId);
        try {
            // Generate and return the JWT response
            JwtResponse jwt = generateJwtResponse(email, keyPair.getPrivate());

            return AuthResponse.builder()
                    .accessToken(jwt.getToken())
                    .refreshToken(jwt.getRefreshToken())
                    .user(userService.getUserById(userId))
                    .build();

        } catch (InterruptedException | ExecutionException e) {
            // Handle exceptions by interrupting the thread and throwing a BadCredentialsException
            Thread.currentThread().interrupt();
            throw new BadCredentialsException("Error while generating token");
        }
    }

    // Authenticates a user and returns a JWT response
    @Override
    public AuthResponse login(AuthenticationRequest request) {
        // Load user details by email
        CustomUserSecurity user = (CustomUserSecurity) userDetailsService.loadUserByUsername(request.getEmail());
        // Authenticate the user with the provided email and password
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword()));
        // If authentication is successful, create and return the JWT response
        if (authentication.isAuthenticated()) {
            return createResponse(request.getEmail(), user.getId());
        } else {
            // Throw an exception if authentication fails
            throw new BadCredentialsException("Invalid email or password");
        }
    }

    @Override
    public AuthResponse oauth2GoogleLogin(GooglePojo googlePojo) {
        if (!googlePojo.isEmailVerified())
            throw new BadCredentialsException("Email is not verified");

        UserDTO user;
        try {
            user = userService.getByEmail(googlePojo.getEmail());
        } catch (UserNotFoundException e) {
            log.info("User not found, creating new user");
            user = null;
        }

        if (user == null) {
            user = userService.createUser(googlePojo);
        } else if (!user.isStatus()) {
            throw new BadCredentialsException("User is not active");
        }
        return createResponse(user.getEmail(), user.getId());
    }


    @Override
    public void logout(String token, String refreshToken) {
        // Logs out a user by blacklisting their tokens and clearing the security context
        // Blacklist the provided access and refresh tokens
        tokenService.blacklistTokens(token, refreshToken);
        // Clear the security context
        SecurityContextHolder.clearContext();
    }

    @Override
    // Refreshes the JWT token using the provided refresh token
    public JwtResponse refreshToken(String token) {
        // Extract email from the token payload
        String email = jwtHelper.extractEmailFromPayload(token);
        if (email == null) {
            // Throw an exception if the email is not found in the token
            throw new BadCredentialsException("Invalid refresh token");
        }

        // Load user details by email
        CustomUserSecurity user = (CustomUserSecurity) userDetailsService.loadUserByUsername(email);
        // Retrieve the key pair associated with the user
        KeyPair keyPair = keyService.getKeyPairByUser(user.getId());
        // Validate the provided token using the user's public key
        boolean isValid = jwtService.validateToken(token, keyPair.getPublic());
        if (!isValid) {
            // Throw an exception if the token is invalid
            throw new BadCredentialsException("Invalid refresh token");
        }

        try {
            // Generate a new JWT response with access and refresh tokens
            JwtResponse jwtResponse = generateJwtResponse(user.getEmail(), keyPair.getPrivate());
            // Blacklist the old refresh token
            tokenService.blacklistTokens(user.getId(), null, token);

            // Return the new JWT response
            return jwtResponse;
        } catch (InterruptedException | ExecutionException e) {
            // Handle exceptions by interrupting the thread and throwing a BadCredentialsException
            Thread.currentThread().interrupt();
            throw new BadCredentialsException("Error while generating token");
        }
    }

}
