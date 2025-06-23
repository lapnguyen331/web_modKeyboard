package org.modKeyboard.repository;

import org.modKeyboard.entity.KeyPair;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.UUID;

public interface KeyPairRepository extends JpaRepository<KeyPair, UUID> {

    @Query("SELECT k FROM KeyPair k WHERE k.user.id = :id")
    KeyPair findByUserId(@Param("id") UUID userId);
}
