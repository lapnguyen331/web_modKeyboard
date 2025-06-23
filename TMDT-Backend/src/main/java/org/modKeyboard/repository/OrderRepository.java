package org.modKeyboard.repository;

import org.modKeyboard.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.UUID;

public interface OrderRepository extends JpaRepository<Order, UUID> {

  @Query("""
      SELECT COUNT(oi) >0
      FROM Order o
      JOIN orderItems oi
      WHERE o.user.id =:userId
      AND o.status ='DELIVERED'
      AND oi.product.id = :productId
      """)
  boolean existsByUserIdAndProductId(@Param("userId") UUID userId, @Param("productId") UUID productId);
}
