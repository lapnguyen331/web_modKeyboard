package org.modKeyboard.eventlistner.listener;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

import org.modKeyboard.eventlistner.event.ProductViewEvent;
import org.modKeyboard.repository.ProductRepository;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
@Slf4j
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public class ProductEventListener {
  ProductRepository productRepository;

  @Async
  @EventListener
  public void handleProductViewed(ProductViewEvent event) {
    var productId = event.productId();
    productRepository
        .findById(productId)
        .ifPresentOrElse((product) -> {
          product.increaseViewCount();
          productRepository.save(product);
        }, () -> log.warn("Product with ID {} not found during view count update", productId));

  }
}
