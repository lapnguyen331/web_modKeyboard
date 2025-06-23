package org.modKeyboard.service.impl;

import org.springframework.stereotype.Component;

import java.security.KeyPair;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class KeyPairCache {

    private final ConcurrentHashMap<UUID, KeyPair> cache = new ConcurrentHashMap<>();

    public KeyPair get(UUID userId) {
        return cache.get(userId);
    }

    public void put(UUID userId, KeyPair keyPair) {
        cache.put(userId, keyPair);
    }

    public boolean contains(UUID userId) {
        return cache.containsKey(userId);
    }

    public void invalidate(UUID userId) {
        cache.remove(userId);
    }

    public void clear() {
        cache.clear();
    }
}

