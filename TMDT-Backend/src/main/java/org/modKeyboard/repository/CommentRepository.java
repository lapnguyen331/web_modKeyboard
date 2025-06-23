package org.modKeyboard.repository;

import org.modKeyboard.entity.Comment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface CommentRepository extends JpaRepository<Comment, UUID> {

  @Query("SELECT c FROM Comment c WHERE c.product.id = :productId AND c.parentComment IS NULL AND c.isDeleted = false")
  Page<Comment> findTopLevelByProductId(@Param("productId") UUID productId, Pageable pageable);

  List<Comment> findByParentCommentId(UUID id);
}
