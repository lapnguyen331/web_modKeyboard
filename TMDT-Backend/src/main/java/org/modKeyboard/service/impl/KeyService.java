package org.modKeyboard.service.impl;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.modKeyboard.entity.KeyPair;
import org.modKeyboard.entity.User;
import org.modKeyboard.exception.KeyGenerationException;
import org.modKeyboard.repository.KeyPairRepository;
import org.modKeyboard.service.IKeyService;
import org.modKeyboard.util.AESEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class KeyService implements IKeyService {
    AESEncoder encoder;
    KeyPairRepository keyRepository;
    KeyPairCache keyPairCache;
    JwtService jwtService;

    @Override
    // Generates a new RSA key pair
    public java.security.KeyPair generateKeyPair() {
        KeyPairGenerator keyPairGenerator = null;
        try {
            // Initialize the key pair generator with RSA algorithm and 2048-bit key size
            keyPairGenerator = KeyPairGenerator.getInstance("RSA");
            keyPairGenerator.initialize(2048);
        } catch (NoSuchAlgorithmException e) {
            // Throw a custom exception if the key pair generation fails
            throw new KeyGenerationException("Failed to generate key pair", e);
        }
        // Generate the key pair
        java.security.KeyPair keyPair = keyPairGenerator.generateKeyPair();
        return keyPair;
    }

    @Override
    // Retrieves the key pair associated with a specific user
    public java.security.KeyPair getKeyPairByUser(UUID userId) {
        // Get the key pair from Redis using the user ID
        if (keyPairCache.contains(userId)) {
            return keyPairCache.get(userId);
        }

        KeyPair key = keyRepository.findByUserId(userId);
        java.security.KeyPair keyPair;

        if (key != null) {
            // Decode the private key if the key pair exists
            String privateKey = encoder.decode(key.getPrivateKey());
            keyPair = new java.security.KeyPair(
                    jwtService.getPublicKeyFromBase64String(key.getPublicKey()),
                    jwtService.getPrivateKeyFromBase64String(privateKey)
            );
        } else {
            // Generate and save a new key pair if it does not exist
            keyPair = generateKeyPair();
            this.save(keyPair, userId);
        }

        // Store the key pair in cache
        keyPairCache.put(userId, keyPair);

        return keyPair;
    }

    @Override
    // Saves the key pair for a specific user
    public void save(java.security.KeyPair keyPair, UUID userId) {

        KeyPair key = KeyPair.builder()
                .privateKey(Base64.getEncoder().encodeToString(keyPair.getPrivate().getEncoded()))
                .publicKey(Base64.getEncoder().encodeToString((keyPair.getPublic().getEncoded())))
                .user(new User(userId))
                .build();


        // Encode the private key before saving
        key.setPrivateKey(encoder.encode(key.getPrivateKey()));

        // Save the key pair to the repository
        keyRepository.save(key);
    }

    @Override
    @Transactional
    public java.security.KeyPair resetKeyPair(UUID userId) {
        // Delete the existing key pair associated with the user
        KeyPair keys = keyRepository.findByUserId(userId);
        if (keys == null) {
            throw new KeyGenerationException("Key pair not found for user: " + userId);
        }

        // Generate a new key pair
        java.security.KeyPair keyPair = generateKeyPair();

        // Encode the private key before saving
        String privateKey = encoder.encode(
                Base64.getEncoder().encodeToString(keyPair.getPrivate().getEncoded())
        );
        keys.setPublicKey(Base64.getEncoder().encodeToString((keyPair.getPublic().getEncoded())));
        keys.setPrivateKey(privateKey);
        // Save the updated key pair to the repository
        keyRepository.save(keys);

        // update the cache
        keyPairCache.put(userId, keyPair);

        // Return the new key pair
        return keyPair;
    }

}
