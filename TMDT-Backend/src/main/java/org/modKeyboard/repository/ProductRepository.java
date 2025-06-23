package org.modKeyboard.repository;

import org.modKeyboard.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface ProductRepository extends JpaRepository<Product, UUID> {

  @Query("SELECT p FROM Product p WHERE " +
      "(:keyword IS NULL OR " +
      "LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
      "LOWER(p.category.name) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND " +
      "p.isDeleted = false")
  Page<Product> searchProductsByKeyword(@Param("keyword") String keyword, Pageable pageable);

  @Query("SELECT p FROM Product p WHERE " +
      "(COALESCE(:categoryIds, NULL) IS NULL OR p.category.id IN :categoryIds) AND " +
      "(:minPrice IS NULL OR p.price >= :minPrice) AND " +
      "(:maxPrice IS NULL OR p.price <= :maxPrice) AND " +
      "(:minRating IS NULL OR p.rating >= :minRating) AND " +
      "p.isDeleted = false")
  Page<Product> filterProducts(
      @Param("categoryIds") List<UUID> categoryIds,
      @Param("minPrice") Double minPrice,
      @Param("maxPrice") Double maxPrice,
      @Param("minRating") Double minRating,
      Pageable pageable);

  @Query("SELECT p FROM Product p WHERE " +
      "(COALESCE(:categoryIds, NULL) IS NULL OR p.category.id IN :categoryIds) AND " +
      "(:minPrice IS NULL OR p.price >= :minPrice) AND " +
      "(:maxPrice IS NULL OR p.price <= :maxPrice) AND " +
      "(:minRating IS NULL OR p.rating >= :minRating) AND " +
      "(:keyword IS NULL OR " +
      "LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
      "LOWER(p.category.name) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND " +
      "p.isDeleted = false")
  Page<Product> searchAndFilterProducts(
      @Param("keyword") String keyword,
      @Param("categoryIds") List<UUID> categoryIds,
      @Param("minPrice") Double minPrice,
      @Param("maxPrice") Double maxPrice,
      @Param("minRating") Double minRating,
      Pageable pageable);

  @Query("""
      SELECT p from Product p
      WHERE p.isDeleted=true
        """)
  List<Product> findAllDeleted();

  long countByIsDeletedTrue();
}
