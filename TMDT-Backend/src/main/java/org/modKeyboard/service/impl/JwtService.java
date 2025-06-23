package org.modKeyboard.service.impl;

import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.sql.Timestamp;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;

import org.modKeyboard.entity.BlackListToken;
import org.modKeyboard.exception.KeyGenerationException;
import org.modKeyboard.repository.BlackListTokenRepository;
import org.modKeyboard.util.JwtHelper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Example;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class JwtService {
  final JwtHelper jwtHelper;
  final UserDetailServiceImpl userDetailService;
  final BlackListTokenRepository blackListRepo;
  @Value("${jwt.access_token.duration}")
  long ACCESS_TOKEN_LIFETIME;
  @Value("${jwt.refresh_token.duration}")
  long REFRESH_TOKEN_LIFETIME;

  @Async
  public CompletableFuture<String> generateAccessToken(String email, PrivateKey privateKey) {
    return generateToken(email, privateKey, ACCESS_TOKEN_LIFETIME);
  }

  @Async
  public CompletableFuture<String> generateRefreshToken(String email, PrivateKey privateKey) {
    return generateToken(email, privateKey, REFRESH_TOKEN_LIFETIME);
  }

  @Async
  public CompletableFuture<String> generateAccessToken(String email, String privateKey) {
    return generateToken(email, privateKey, ACCESS_TOKEN_LIFETIME);
  }

  @Async
  public CompletableFuture<String> generateRefreshToken(String email, String privateKey) {
    return generateToken(email, privateKey, REFRESH_TOKEN_LIFETIME);
  }

  // Generates a JWT token asynchronously
  private CompletableFuture<String> generateToken(String email, PrivateKey privateKey, long lifetime) {
    // Return null if email is null
    if (email == null)
      return null;

    return CompletableFuture.supplyAsync(() -> {

      // Load user details by email
      // CustomUserSecurity user = (CustomUserSecurity)
      // userDetailService.loadUserByUsername(email);
      // Create claims map and add JID and role
      Map<String, Object> claims = new HashMap<>();
      claims.put("jid", UUID.randomUUID().toString());
      // claims.put("roles",
      // user.getAuthorities().stream().findFirst().get().getAuthority());

      try {
        // Build JWT token
        JwtBuilder jwt = Jwts.builder().setHeaderParam("type", "JWT")
            .setClaims(claims)
            .setSubject(email)
            .setIssuedAt(new Date(System.currentTimeMillis()))
            .setExpiration(new Date(System.currentTimeMillis() + lifetime))
            .signWith(privateKey, SignatureAlgorithm.RS256);
        // Return the compact JWT token
        return jwt.compact();
      } catch (Exception e) {
        throw new JwtException("Error while creating token", e);
      }
    });

  }

  private CompletableFuture<String> generateToken(String email, String privateKey, long lifetime) {
    // Get private key from base64 string
    PrivateKey key = getPrivateKeyFromBase64String(privateKey);

    // Build JWT token
    return this.generateToken(email, key, lifetime);
  }

  // Converts a base64 encoded private key string to a PrivateKey object
  public PrivateKey getPrivateKeyFromBase64String(String privateKey) {
    try {
      KeyFactory keyFactory = KeyFactory.getInstance("RSA");
      PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(Base64.getDecoder().decode(privateKey));
      return keyFactory.generatePrivate(privateKeySpec);
    } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
      throw new KeyGenerationException("Error while generating private key", e);
    }
  }

  // Converts a base64 encoded public key string to a PublicKey object
  public PublicKey getPublicKeyFromBase64String(String publicKey) {
    try {
      KeyFactory keyFactory = KeyFactory.getInstance("RSA");
      X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(Base64.getDecoder().decode(publicKey));
      return keyFactory.generatePublic(publicKeySpec);
    } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
      throw new KeyGenerationException("Error while generating public key", e);
    }
  }

  // Validates a JWT token using the provided public key
  public boolean validateToken(String token, PublicKey publicKey) throws ExpiredJwtException {
    // Extract email from token
    final String emailEx = jwtHelper.getEmailFromToken(token, publicKey);
    // Load user details by email
    userDetailService.loadUserByUsername(emailEx);
    // Extract JID from token
    String jid = jwtHelper.getJidToken(token, publicKey);
    // Check if token is not expired and not in blacklist
    return !isTokenExpired(token, publicKey) && !isExistsInBlacklist(jid);
  }

  private boolean isTokenExpired(String token, PublicKey key) {
    return jwtHelper.getExpiryToken(token, key).before(new Timestamp(System.currentTimeMillis()));
  }

  private boolean isExistsInBlacklist(String jid) {
    Example<BlackListToken> example = Example.of(BlackListToken.builder().jid(jid).build());
    return blackListRepo.exists(example);
  }
}
