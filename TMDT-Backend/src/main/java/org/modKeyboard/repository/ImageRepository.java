package org.modKeyboard.repository;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.entity.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<ProductImage, UUID> {
  List<ProductImage> findByProductId(UUID productId);

}
