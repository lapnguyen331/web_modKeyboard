package org.modKeyboard.repository;

import org.modKeyboard.entity.CartItem;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface CartItemRepository extends JpaRepository<CartItem, UUID> {

    @Query("""
                    SELECT c FROM CartItem c
                    JOIN c.cart cart
                    WHERE cart.user.id = :userId
                
            """)
    List<CartItem> findCartItemByUser(@Param("userId") UUID userId, Sort sort);

    @Query("""
                    SELECT c FROM CartItem c
                    JOIN c.cart cart
                    WHERE cart.id = :cartId AND c.product.id = :productId
            """)
    Optional<CartItem> findItemByProduct(@Param("cartId") UUID cartId, @Param("productId") UUID productId);

    @Query("""
                    SELECT SUM(c.quantity) FROM CartItem c
                    JOIN c.cart cart
                    WHERE cart.user.id = :userId
            """)
    Optional<Integer> countTotalQuantities(UUID userId);
}
