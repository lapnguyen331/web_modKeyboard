package org.modKeyboard.repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.modKeyboard.entity.Rating;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface RatingRepository extends JpaRepository<Rating, UUID> {
  @Query("""
      SELECT AVG(r.rating)
      FROM Rating r
      WHERE r.product.id = :productId
      """)
  Optional<Double> getAverageRatingByProductId(UUID productId);

  Page<Rating> findByProductId(UUID productId, Pageable pageable);

  Page<Rating> findByProductIdAndRating(UUID productId, byte ratingFilter, Pageable pageable);

  List<Rating> findByProductId(UUID productId);

  boolean existsByUserIdAndProductId(UUID userId, UUID productId);

}
