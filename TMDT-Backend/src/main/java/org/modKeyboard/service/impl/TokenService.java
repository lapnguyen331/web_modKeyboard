package org.modKeyboard.service.impl;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.modKeyboard.dto.CustomUserSecurity;
import org.modKeyboard.exception.UnauthorizedActionException;
import org.modKeyboard.repository.BlackListTokenRepository;
import org.modKeyboard.service.IKeyService;
import org.modKeyboard.service.ITokenService;
import org.modKeyboard.util.UserSecurityHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class TokenService implements ITokenService {
    JwtService jwtService;
    IKeyService keyService;
    AsyncTokenService asyncTokenService;
    BlackListTokenRepository blackListTokenRepo;


    @Override
    @Transactional
    public void removeExpiredTokens() {
        List<UUID> tokenExpired = new ArrayList<>();

        Timestamp now = new Timestamp(System.currentTimeMillis());
        // Check for expired tokens in the database
        blackListTokenRepo.findAll().forEach(token -> {
            // check token expired
            if (token.getExpiredAt().before(now)) {
                tokenExpired.add(token.getId());
            }
        });

        if (!tokenExpired.isEmpty())
            blackListTokenRepo.deleteAllById(tokenExpired);
    }

    @Override
    // Blacklists the provided access and refresh tokens for the current user
    public void blacklistTokens(String accessToken, String refreshToken) {
        // Retrieve the current user from the security context
        CustomUserSecurity currentUser = UserSecurityHelper.getCurrentUser();
        this.blacklistTokens(currentUser.getId(), accessToken, refreshToken);
    }

    @Override
    // Blacklists the provided access and refresh tokens for the current user
    public void blacklistTokens(UUID userId, String accessToken, String refreshToken) {
        // Retrieve the key pair associated with the current user
        java.security.KeyPair keyPair = keyService.getKeyPairByUser(userId);

        // Validate the provided refresh token using the user's public key
        if (!jwtService.validateToken(refreshToken, keyPair.getPublic())) {
            // Throw an exception if the refresh token is invalid
            throw new UnauthorizedActionException("Invalid refresh token");
        }

        // Asynchronously blacklist the provided access token
        asyncTokenService.blacklistAccessToken(accessToken, keyPair.getPublic());
        // Asynchronously blacklist the provided refresh token
        asyncTokenService.blacklistRefreshToken(refreshToken, keyPair.getPublic());
    }


}
