package org.modKeyboard.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.modKeyboard.util.UUIDGenerator;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.sql.Timestamp;
import java.util.UUID;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "user_otp")
public class UserOtp {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(name = "UUID", type = UUIDGenerator.class)
    @Column(updatable = false, columnDefinition = "char(36)")
    @JdbcTypeCode(SqlTypes.CHAR)
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "otp_code", nullable = false, unique = true)
    private String otpCode;

    @Column(name = "type", nullable = false)
    @Enumerated(EnumType.STRING)
    private UserOtp.OtpType type;

    @Column(name = "expired_at", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Timestamp expiredAt;

    public enum OtpType {
        FORGOT_PASSWORD, VERIFY_EMAIL
    }
}