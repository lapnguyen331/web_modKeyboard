package org.modKeyboard.service;


import java.util.UUID;

public interface ITokenService {

    void removeExpiredTokens();

    void blacklistTokens(String accessToken, String refreshToken);

    void blacklistTokens(UUID userId, String accessToken, String refreshToken);

}
