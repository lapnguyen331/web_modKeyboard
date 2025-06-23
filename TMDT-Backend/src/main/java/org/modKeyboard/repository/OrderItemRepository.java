package org.modKeyboard.repository;

import java.util.Optional;
import java.util.UUID;

import org.modKeyboard.entity.OrderItem;
import org.modKeyboard.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface OrderItemRepository extends JpaRepository<OrderItem, UUID> {

  @Query("""
      SELECT product
      FROM OrderItem
      GROUP BY product.id
      ORDER BY SUM(quantity) DESC
      """)
  Page<Product> findProductsByBestSelling(Pageable pageable);

  @Query("""
      SELECT SUM(quantity)
      FROM OrderItem
      WHERE product.id = :productId
      """)
  Optional<Long> countByProductId(@Param("productId") UUID productId);
}
