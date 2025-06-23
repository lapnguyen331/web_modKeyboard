package org.modKeyboard.repository;

import org.modKeyboard.entity.BlackListToken;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface BlackListTokenRepository extends JpaRepository<BlackListToken, UUID> {
}
