package org.modKeyboard.service;


import java.util.UUID;

public interface IKeyService {
    java.security.KeyPair generateKeyPair();

    java.security.KeyPair getKeyPairByUser(UUID userId);

    void save(java.security.KeyPair keyPair, UUID userId);

    java.security.KeyPair resetKeyPair(UUID userId);

}
