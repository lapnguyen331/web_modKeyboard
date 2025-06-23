package org.modKeyboard.service.impl;

import static lombok.AccessLevel.PRIVATE;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.product.ProductCreateRequest;
import org.modKeyboard.dto.request.product.ProductImagesUpdateRequest;
import org.modKeyboard.dto.request.product.ProductUpdateRequest;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.ProductDetailResponse;
import org.modKeyboard.dto.response.ProductSummaryResponse;
import org.modKeyboard.entity.Product;
import org.modKeyboard.eventlistner.event.ImageAttachEvent;
import org.modKeyboard.eventlistner.event.ImageUpdateEvent;
import org.modKeyboard.eventlistner.event.ProductViewEvent;
import org.modKeyboard.exception.ResourceNotFoundException;
import org.modKeyboard.mapper.ProductMapper;
import org.modKeyboard.repository.ProductRepository;
import org.modKeyboard.service.IAdminProductService;
import org.modKeyboard.service.ICategoryService;
import org.modKeyboard.service.IMediaService;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@FieldDefaults(level = PRIVATE, makeFinal = true)
@RequiredArgsConstructor
@Service
public class AdminProductService implements IAdminProductService {
  ProductRepository productRepository;
  ProductMapper productMapper;
  ICategoryService categoryService;
  IMediaService mediaService;
  ApplicationEventPublisher eventPublisher;

  @Override
  public Product findById(UUID productId) {
    return productRepository.findById(productId)
        .orElseThrow(() -> new ResourceNotFoundException("Product with id " + productId + " not found"));
  }

  @Override
  public ProductDetailResponse getProductDetail(UUID productId) {
    var product = findById(productId);
    if (product.getIsDeleted())
      throw new ResourceNotFoundException("Product with id " + productId + " deleted");
    eventPublisher.publishEvent(new ProductViewEvent(productId));
    var productImagesResponse = mediaService.getImagesByProductId(productId);
    var productDetail = productMapper.toProductDetail(product, productImagesResponse);
    return productDetail;
  }

  @Override
  public PageResponse<List<ProductSummaryResponse>> getProducts(PageRequest pageable, String q) {
    Page<Product> productsPage;
    if (q == null) {
      productsPage = productRepository.findAll(pageable);
    } else {
      try {
        UUID productId = UUID.fromString(q);
        var product = findById(productId);
        productsPage = new PageImpl<>(List.of(product), pageable, 1);
      } catch (IllegalArgumentException ex) {
        productsPage = productRepository.searchProductsByKeyword(q, pageable);
      }
    }
    var products = productsPage.getContent();
    var productDTOs = productMapper.toProductSummaries(products);
    return PageResponse.<List<ProductSummaryResponse>>builder()
        .currentPage(productsPage.getNumber() + 1)
        .totalPage(productsPage.getTotalPages())
        .data(productDTOs)
        .build();
  }

  @Override
  public void createProduct(ProductCreateRequest request) {
    var category = categoryService.getReferenceIfExists(request.getCategoryId());
    var product = productMapper.toProduct(request, category);
    var savedProduct = productRepository.save(product);
    eventPublisher.publishEvent(new ImageAttachEvent(savedProduct.getId(), request.getImageIds()));
  }

  @Override
  public void softDeleteProduct(UUID productId) {
    var currentProduct = findById(productId);
    productRepository.delete(currentProduct);
  }

  @Override
  public List<ProductSummaryResponse> getDeletedProducts() {
    var deletedProducts = productRepository.findAllDeleted();
    return productMapper.toProductSummaries(deletedProducts);

  }

  @Override
  public long getDeletedProductCount() {
    return productRepository.countByIsDeletedTrue();
  }

  @Override
  public void recoverProduct(UUID productId) {
    var currentProduct = findById(productId);
    currentProduct.setIsDeleted(false);
    productRepository.save(currentProduct);
  }

  @Override
  public void updateProduct(ProductUpdateRequest request) {
    var currentProduct = findById(request.getId());
    productMapper.setProductFromRequest(currentProduct, request);
    if (request.getCategoryId() != currentProduct.getCategory().getId()) {
      var newCategory = categoryService.getReferenceIfExists(request.getCategoryId());
      currentProduct.setCategory(newCategory);
    }
    productRepository.save(currentProduct);
  }

  @Override
  public void updateProductImages(UUID productId, ProductImagesUpdateRequest request) {
    var currentProduct = findById(productId);
    currentProduct.setThumbnail(request.thumbnail());
    productRepository.save(currentProduct);
    eventPublisher.publishEvent(new ImageUpdateEvent(currentProduct.getId(), request.imageIds()));
  }

}
