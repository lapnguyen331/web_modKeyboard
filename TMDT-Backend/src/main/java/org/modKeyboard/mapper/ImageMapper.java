package org.modKeyboard.mapper;

import org.modKeyboard.dto.response.ImageResponse;
import org.modKeyboard.entity.ProductImage;
import org.springframework.stereotype.Component;

@Component
public class ImageMapper {
  public ImageResponse toImageResponse(ProductImage productImage) {
    return new ImageResponse(
        productImage.getId(),
        productImage.getImagePath(),
        productImage.getUploadedAt());
  }

}
