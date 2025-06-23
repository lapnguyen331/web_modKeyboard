package org.modKeyboard.repository;

import org.modKeyboard.dto.response.category.CategoryDetailResponse;
import org.modKeyboard.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface CategoryRepository extends JpaRepository<Category, UUID> {
  List<Category> findAllByIsDeletedFalse();

  @Query("""
          SELECT new org.modKeyboard.dto.response.category.CategoryDetailResponse(
              c.id, c.name, c.isDeleted, c.description, c.createdAt,
              COUNT(p), COALESCE(SUM(p.sold), 0)
          )
          FROM Category c
          LEFT JOIN Product p ON p.category = c
          WHERE c.id = :categoryId
          GROUP BY c.id, c.name, c.isDeleted, c.description, c.createdAt
      """)
  Optional<CategoryDetailResponse> getCategoryDetailById(@Param("categoryId") UUID categoryId);
}
