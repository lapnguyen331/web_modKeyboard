package org.modKeyboard.entity;

import java.util.UUID;

import org.modKeyboard.util.UUIDGenerator;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper = false)
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "ratings")
public class Rating extends Auditable {
  @Id
  @GeneratedValue(generator = "UUID")
  @GenericGenerator(name = "UUID", type = UUIDGenerator.class)
  @Column(updatable = false, columnDefinition = "char(36)")
  @JdbcTypeCode(SqlTypes.CHAR)
  private UUID id;

  @ManyToOne
  @JoinColumn(name = "product_id", nullable = false)
  private Product product;

  @ManyToOne
  @JoinColumn(name = "user_id", nullable = false)
  private User user;

  @Column(name = "rating", nullable = false)
  private byte rating;

  @Column(name = "content", nullable = false, length = 300)
  private String content;
}
