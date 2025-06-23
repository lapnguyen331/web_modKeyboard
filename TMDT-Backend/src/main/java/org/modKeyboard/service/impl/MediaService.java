package org.modKeyboard.service.impl;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.modKeyboard.dto.response.ImageResponse;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.entity.ProductImage;
import org.modKeyboard.mapper.ImageMapper;
import org.modKeyboard.repository.ImageRepository;
import org.modKeyboard.service.IMediaService;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class MediaService implements IMediaService {
  Cloudinary cloudinary;
  ImageRepository imageRepository;
  ImageMapper imageMapper;

  @Override
  public ImageResponse uploadImage(MultipartFile file) {
    try {
      Map uploadResult = cloudinary
          .uploader().upload(file.getBytes(), ObjectUtils.emptyMap());
      var url = uploadResult.get("secure_url").toString();
      var productImage = ProductImage.builder().imagePath(url).build();
      var savedProductImage = imageRepository.save(productImage);
      return imageMapper.toImageResponse(savedProductImage);
    } catch (IOException e) {
      throw new RuntimeException("Failed to upload image");
    }
  }

  @Override
  public PageResponse<List<ImageResponse>> getImages(PageRequest pageable) {
    var imagePage = imageRepository.findAll(pageable);
    var images = imagePage.getContent();
    var imageResponses = images
        .stream()
        .map(imageMapper::toImageResponse).toList();
    return PageResponse.<List<ImageResponse>>builder()
        .currentPage(imagePage.getNumber() + 1)
        .totalPage(imagePage.getTotalPages())
        .data(imageResponses)
        .build();
  }

  @Override
  public List<ImageResponse> getImagesByProductId(UUID productId) {
    var productImages = imageRepository.findByProductId(productId);
    return productImages
        .stream()
        .map(imageMapper::toImageResponse)
        .toList();
  }
}
