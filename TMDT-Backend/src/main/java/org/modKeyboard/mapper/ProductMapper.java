package org.modKeyboard.mapper;

import org.modKeyboard.dto.request.product.ProductCreateRequest;
import org.modKeyboard.dto.request.product.ProductUpdateRequest;
import org.modKeyboard.dto.response.ImageResponse;
import org.modKeyboard.dto.response.ProductDetailResponse;
import org.modKeyboard.dto.response.ProductSummaryResponse;
import org.modKeyboard.entity.Category;
import org.modKeyboard.entity.Product;
import org.springframework.stereotype.Component;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Component
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class ProductMapper {
  CategoryMapper categoryMapper;

  public ProductDetailResponse toProductDetail(Product product, List<ImageResponse> productImagesResponse) {
    return new ProductDetailResponse(
        toProductSummary(product),
        product.getDescription(),
        productImagesResponse);
  }

  public ProductSummaryResponse toProductSummary(Product product) {
    return new ProductSummaryResponse(
        product.getId(),
        categoryMapper.toResponse(product.getCategory()),
        product.getName(),
        product.getTotalViews(),
        product.getVolume(),
        product.getThumbnail(),
        product.getPrice(),
        product.getDiscountPrice() == null ? 0.0 : product.getDiscountPrice(),
        product.getQuantity(),
        product.getQuantity(),
        product.getSold());
  }

  public Product toProduct(ProductCreateRequest request, Category category) {
    return Product
        .builder()
        .name(request.getName())
        .category(category)
        .description(request.getDescription())
        .volume(request.getVolume())
        .price(request.getPrice())
        .discountPrice(request.getDiscountPrice() == 0.0 ? null : request.getDiscountPrice())
        .quantity(request.getQuantity())
        .sold(0)
        .totalViews(0)
        .rating(0.0)
        .thumbnail(request.getThumbnail())
        .build();
  }

  public List<ProductSummaryResponse> toProductSummaries(List<Product> products) {
    return products.stream().map(this::toProductSummary).toList();
  }

  public void setProductFromRequest(Product product, ProductUpdateRequest request) {
    product.setName(request.getName());
    product.setDescription(request.getDescription());
    product.setVolume(request.getVolume());
    product.setQuantity(request.getQuantity());
    product.setPrice(request.getPrice());
    if (request.getDiscountPrice() > 0) {
      product.setDiscountPrice(request.getDiscountPrice());
    }

  }
}
