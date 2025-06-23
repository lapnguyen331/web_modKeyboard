package org.modKeyboard.eventlistner.listener;

import java.util.UUID;

import org.modKeyboard.entity.Product;
import org.modKeyboard.entity.ProductImage;
import org.modKeyboard.eventlistner.event.ImageAttachEvent;
import org.modKeyboard.eventlistner.event.ImageUpdateEvent;
import org.modKeyboard.repository.ImageRepository;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@AllArgsConstructor
@Slf4j
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public class ImageAttachListener {
  ImageRepository imageRepository;

  public void attachImage(ProductImage image, Product product) {
    image.setIsTemporary(false);
    image.setProduct(product);
    imageRepository.save(image);
  }

  @Async
  @EventListener
  @Transactional
  public void handleUpdateImages(ImageUpdateEvent event) {
    var productId = event.productId();
    var product = new Product(event.productId());
    var newImageIds = event.imageIds()
        .stream()
        .map(UUID::fromString)
        .toList();
    var currentImages = imageRepository.findByProductId(productId);
    var currentImageIds = imageRepository.findByProductId(productId)
        .stream()
        .map(ProductImage::getId)
        .toList();
    // Detach images
    for (var image : currentImages) {
      if (!newImageIds.contains(image.getId())) {
        image.setProduct(null);
        image.setIsTemporary(true);
        imageRepository.save(image);
      }
    }
    for (var imageId : newImageIds) {
      if (!currentImageIds.contains(imageId)) {
        imageRepository.findById(imageId)
            .ifPresentOrElse(image -> attachImage(image, product),
                () -> log.warn("image not found with ID {}", imageId));
        ;
      }
    }
  }

  @Async
  @EventListener
  @Transactional
  public void handleAttachImages(ImageAttachEvent event) {
    var product = new Product(event.productId());
    event.imageIds()
        .parallelStream()
        .forEach(imageId -> {
          imageRepository
              .findById(UUID.fromString(imageId))
              .ifPresentOrElse(image -> attachImage(image, product), () -> {
                log.warn("Image not found with ID {}", imageId);
              });

        });
  }

}
