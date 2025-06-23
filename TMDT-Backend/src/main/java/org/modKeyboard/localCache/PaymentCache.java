package org.modKeyboard.localCache;

import com.google.gson.JsonObject;
import org.springframework.stereotype.Component;

import java.util.concurrent.ConcurrentHashMap;

@Component
public class PaymentCache {
    private final ConcurrentHashMap<String, JsonObject> cache = new ConcurrentHashMap<>();

    public JsonObject get(String key) {
        return cache.get(key);
    }

    public void put(String key, JsonObject value) {
        cache.put(key, value);
    }

    public boolean contains(String key) {
        return cache.containsKey(key);
    }

    public void invalidate(String key) {
        cache.remove(key);
    }

    public void clear() {
        cache.clear();
    }
}