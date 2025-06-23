package org.modKeyboard.repository;

import org.modKeyboard.dto.enums.RoleEnum;
import org.modKeyboard.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface RoleRepository extends JpaRepository<Role, UUID> {
    Role findByName(RoleEnum name);
}
