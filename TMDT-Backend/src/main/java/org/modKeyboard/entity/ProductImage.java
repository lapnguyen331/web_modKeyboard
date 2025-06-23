package org.modKeyboard.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.modKeyboard.util.UUIDGenerator;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "product_images")

@EntityListeners(AuditingEntityListener.class)
public class ProductImage {
  @Id
  @GeneratedValue(generator = "UUID")
  @GenericGenerator(name = "UUID", type = UUIDGenerator.class)
  @Column(updatable = false, columnDefinition = "char(36)")
  @JdbcTypeCode(SqlTypes.CHAR)
  private UUID id;

  @ManyToOne
  @JoinColumn(name = "product_id", nullable = true)
  private Product product;

  @Column(name = "image_path", nullable = false)
  private String imagePath;

  @Column(name = "is_deleted", columnDefinition = "boolean default false")
  @Builder.Default
  private Boolean isDeleted = false;

  @Column(name = "is_temporary", columnDefinition = "boolean default true")
  @Builder.Default
  private Boolean isTemporary = true;

  @Column(name = "uploaded_at")
  @Temporal(TemporalType.TIMESTAMP)
  @CreatedDate
  private LocalDateTime uploadedAt;
  // Getters and Setters
}
