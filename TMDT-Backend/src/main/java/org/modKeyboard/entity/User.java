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
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Entity
@Table(name = "users")
public class User {
  @Id
  @GeneratedValue(generator = "UUID")
  @GenericGenerator(name = "UUID", type = UUIDGenerator.class)
  @Column(updatable = false, columnDefinition = "char(36)")
  @JdbcTypeCode(SqlTypes.CHAR)
  private UUID id;

  @Column(name = "password", nullable = false)
  private String password;

  @Column(name = "email", nullable = false, unique = true)
  private String email;

  @Column(name = "full_name", nullable = false)
  private String fullName;

  @Column(name = "phone")
  private String phone;

  @Column(name = "status", nullable = false, columnDefinition = "boolean default true")
  private Boolean status = true;

  @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
  @Builder.Default
  private List<UserRole> userRoles = new ArrayList<>();

  public void addUserRole(UserRole role) {
    this.userRoles.add(role);
    role.setUser(this);
  }

  public User(UUID id) {
    this.id = id;
  }
}
