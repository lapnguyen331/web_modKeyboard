package org.modKeyboard.service;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.product.ProductCreateRequest;
import org.modKeyboard.dto.request.product.ProductImagesUpdateRequest;
import org.modKeyboard.dto.request.product.ProductUpdateRequest;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.ProductDetailResponse;
import org.modKeyboard.dto.response.ProductSummaryResponse;
import org.modKeyboard.entity.Product;
import org.springframework.data.domain.PageRequest;

public interface IAdminProductService {
  Product findById(UUID productId);

  ProductDetailResponse getProductDetail(UUID productId);

  PageResponse<List<ProductSummaryResponse>> getProducts(PageRequest pageable, String q);

  List<ProductSummaryResponse> getDeletedProducts();

  long getDeletedProductCount();

  void createProduct(ProductCreateRequest request);

  void updateProduct(ProductUpdateRequest request);

  void softDeleteProduct(UUID productId);

  void recoverProduct(UUID productId);

  void updateProductImages(UUID productId, ProductImagesUpdateRequest request);
}
