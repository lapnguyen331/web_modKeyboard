package org.modKeyboard.repository;

import org.modKeyboard.entity.UserOtp;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface OtpRepository extends JpaRepository<UserOtp, UUID> {

    Optional<UserOtp> findByOtpCode(String otpCode);
    Optional<UserOtp> findByOtpCodeAndType(String otpCode, UserOtp.OtpType type);
}
