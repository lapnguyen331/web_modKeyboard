package org.modKeyboard.controller.admin;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.product.ProductCreateRequest;
import org.modKeyboard.dto.request.product.ProductImagesUpdateRequest;
import org.modKeyboard.dto.request.product.ProductUpdateRequest;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.ProductDetailResponse;
import org.modKeyboard.dto.response.ProductSummaryResponse;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.service.IAdminProductService;
import org.hibernate.validator.constraints.Range;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController("AdminProductController")
@RequestMapping("${API_PREFIX}/admin/products")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class AdminProductController {
  IAdminProductService adminProductService;

  @GetMapping("/{productId}")
  public ResponseObject<ProductDetailResponse> getProductDetail(
      @PathVariable UUID productId) {
    var productDetail = adminProductService.getProductDetail(productId);
    return new ResponseObject<>(HttpStatus.OK, productDetail);
  }

  @GetMapping("/deleted")
  public ResponseObject<List<ProductSummaryResponse>> getDeletedProducts() {
    var response = adminProductService.getDeletedProducts();
    return new ResponseObject<>(HttpStatus.OK, response);
  }

  @GetMapping("/deleted/count")
  public ResponseObject<Long> getDeletedProductCount() {
    var response = adminProductService.getDeletedProductCount();
    return new ResponseObject<>(HttpStatus.OK, response);
  }

  @GetMapping
  public ResponseObject<PageResponse<List<ProductSummaryResponse>>> getProducts(
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size,
      @RequestParam(value = "q", required = false) String q) {
    var sort = Sort.by(Sort.Direction.DESC, "createdAt");
    var pageable = PageRequest.of(page - 1, size, sort);
    var pageResponse = adminProductService.getProducts(pageable, q);
    return new ResponseObject<>(HttpStatus.OK, pageResponse);
  }

  @PostMapping("/{productId}/recover")
  public ResponseObject<ProductSummaryResponse> recoverProduct(
      @PathVariable UUID productId) {
    adminProductService.recoverProduct(productId);
    return new ResponseObject<>(HttpStatus.OK, "product recovered");
  }

  @PostMapping
  public ResponseObject<ProductSummaryResponse> createProduct(
      @RequestBody ProductCreateRequest request) {
    adminProductService.createProduct(request);
    return new ResponseObject<>(HttpStatus.OK, "product created");
  }

  @DeleteMapping("/{productId}")
  public ResponseObject<Void> softDeleteProduct(
      @PathVariable UUID productId) {
    adminProductService.softDeleteProduct(productId);
    return new ResponseObject<>(HttpStatus.OK, "producrt deleted");
  }

  @PutMapping("/{productId}")
  public ResponseObject<Void> updateProduct(
      @PathVariable UUID productId,
      @RequestBody ProductUpdateRequest request) {
    adminProductService.updateProduct(request);
    return new ResponseObject<>(HttpStatus.OK, "product updated");
  }

  @PutMapping("/{productId}/images")
  public ResponseObject<Void> updateProductImages(
      @PathVariable UUID productId,
      @RequestBody ProductImagesUpdateRequest request) {
    adminProductService.updateProductImages(productId, request);
    return new ResponseObject<>(HttpStatus.OK, "product updated");
  }
}
