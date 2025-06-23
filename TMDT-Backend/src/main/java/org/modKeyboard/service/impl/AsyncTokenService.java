package org.modKeyboard.service.impl;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modKeyboard.entity.BlackListToken;
import org.modKeyboard.repository.BlackListTokenRepository;
import org.modKeyboard.util.JwtHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.security.PublicKey;
import java.sql.Timestamp;
import java.time.Duration;
import java.util.Date;
import java.util.concurrent.CompletableFuture;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AsyncTokenService {
  JwtHelper jwtHelper;
  BlackListTokenRepository blackListRepo;

  @Async
  // Asynchronously blacklists an access token for a specific user
  public CompletableFuture<Void> blacklistAccessToken(String accessToken, PublicKey publicKey) {
    // Get the expiration date of the access token
    Date expiredDate = jwtHelper.getExpiryToken(accessToken, publicKey);
    // Get the unique identifier (JID) of the access token
    String accessId = jwtHelper.getJidToken(accessToken, publicKey);

    BlackListToken token = BlackListToken.builder()
        .jid(accessId)
        .expiredAt(new Timestamp(expiredDate.getTime()))
        .build();

    blackListRepo.save(token);
    // Return a completed future
    return CompletableFuture.completedFuture(null);
  }

  @Async
  // Asynchronously blacklists a refresh token for a specific user
  public CompletableFuture<Void> blacklistRefreshToken(String refreshToken, PublicKey publicKey) {
    // Get the expiration date of the refresh token
    Date expiredDate = jwtHelper.getExpiryToken(refreshToken, publicKey);
    // Get the unique identifier (JID) of the refresh token
    String refreshId = jwtHelper.getJidToken(refreshToken, publicKey);

    // Define the duration to extend the expiration date by 2 days
    Duration days = Duration.ofDays(2);

    BlackListToken token = BlackListToken.builder()
        .jid(refreshId)
        .expiredAt(new Timestamp(expiredDate.getTime() + days.toMillis()))
        .build();

    blackListRepo.save(token);
    // Return a completed future
    return CompletableFuture.completedFuture(null);
  }
}
