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
@Table(name = "comments")
public class Comment extends Auditable {
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

  @ManyToOne
  @JoinColumn(name = "parent_comment_id")
  private Comment parentComment;

  @Column(name = "content", nullable = false, length = 2200)
  private String content;

  @Column(name = "is_deleted", columnDefinition = "boolean default false")
  private boolean isDeleted = false;

  public Comment(UUID id) {
    this.id = id;
  }

  public int getDepth() {
    int depth = 0;
    var current = this.parentComment;
    while (current != null) {
      depth++;
      current = current.getParentComment();
    }
    return depth;
  }
}
