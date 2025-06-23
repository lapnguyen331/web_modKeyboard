package org.modKeyboard.entity;

import java.sql.Timestamp;
import java.util.UUID;

import org.modKeyboard.util.UUIDGenerator;
import org.hibernate.annotations.Filter;
import org.hibernate.annotations.FilterDef;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.ParamDef;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.type.SqlTypes;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Entity
@Table(name = "products")
@FilterDef(name = "deletedFilter", parameters = @ParamDef(name = "isDeleted", type = Boolean.class))
@Filter(name = "deletedFilter", condition = "is_deleted = :isDeleted")
@SQLDelete(sql = "UPDATE products SET is_deleted = true WHERE id=?")
public class Product {
  @Id
  @GeneratedValue(generator = "UUID")
  @GenericGenerator(name = "UUID", type = UUIDGenerator.class)
  @Column(updatable = false, columnDefinition = "char(36)")
  @JdbcTypeCode(SqlTypes.CHAR)
  private UUID id;

  @ManyToOne
  @JoinColumn(name = "category_id", nullable = false)
  private Category category;

  @Column(name = "name", nullable = false)
  private String name;

  @Column(name = "description", length = 5000)
  private String description;

  @Column(name = "volume", nullable = false)
  private String volume;

  @Column(name = "thumbnail", nullable = false, length = 1000)
  private String thumbnail;

  @Column(name = "created_at")
  @Temporal(TemporalType.TIMESTAMP)
  @CreatedDate
  private Timestamp createdAt;

  @Column(name = "price", nullable = false)
  private Double price;

  @Column(name = "discount_price")
  private Double discountPrice;

  @Column(name = "quantity", nullable = false)
  private Integer quantity;

  @Column(name = "rating", columnDefinition = "double default 0")
  private Double rating;

  @Column(name = "sold", columnDefinition = "integer default 0")
  private Integer sold;

  @Column(name = "total_views", columnDefinition = "integer default 0")
  private Integer totalViews;

  @Column(name = "is_deleted", columnDefinition = "boolean default false")
  @Builder.Default
  private Boolean isDeleted = false;

  public void increaseViewCount() {
    setTotalViews(getTotalViews() + 1);
  }

  public Product(UUID id) {
    this.id = id;
  }
}
