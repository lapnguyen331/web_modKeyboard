package org.modKeyboard.service.impl;

import static lombok.AccessLevel.PRIVATE;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.function.Function;

import org.modKeyboard.dto.request.product.ProductFilterDTO;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.ProductDetailResponse;
import org.modKeyboard.dto.response.ProductSummaryResponse;
import org.modKeyboard.entity.Product;
import org.modKeyboard.eventlistner.event.ProductViewEvent;
import org.modKeyboard.exception.ResourceNotFoundException;
import org.modKeyboard.mapper.ProductMapper;
import org.modKeyboard.repository.OrderItemRepository;
import org.modKeyboard.repository.ProductRepository;
import org.modKeyboard.repository.RatingRepository;
import org.modKeyboard.service.IMediaService;
import org.modKeyboard.service.IProductService;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@FieldDefaults(level = PRIVATE, makeFinal = true)
@RequiredArgsConstructor
@Service
public class ProductService implements IProductService {
  ProductRepository productRepository;
  OrderItemRepository orderItemRepo;
  ProductMapper productMapper;
  RatingRepository ratingRepository;
  IMediaService mediaService;
  ApplicationEventPublisher eventPublisher;

  @Override
  public List<ProductSummaryResponse> getNewestProducts(Pageable pageable) {
    return getProductsAsDTOs(pageable, productRepository::findAll);
  }

  @Override
  public List<ProductSummaryResponse> getBestSellerProducts(Pageable pageable) {
    return getProductsAsDTOs(pageable, orderItemRepo::findProductsByBestSelling);
  }

  @Override
  public List<ProductSummaryResponse> getMostViewedProducts(Pageable pageable) {
    return getProductsAsDTOs(pageable, productRepository::findAll);
  }

  /**
   * Converts a pageable list of Product entities to a list of
   * ProductDetailResponse objects.
   * Adds additional information such as average rating and sold count to each
   * ProductDetailResponse.
   * 
   * @param pageable        the pagination information
   * @param productFunction a function to retrieve a pageable list of Product
   *                        entities
   * @return a list of ProductDetailResponse objects with additional information
   */
  private List<ProductSummaryResponse> getProductsAsDTOs(Pageable pageable,
      Function<Pageable, Page<Product>> productFunction) {
    List<Product> products = productFunction.apply(pageable).getContent();
    List<ProductSummaryResponse> results = productMapper.toProductSummaries(products);
    return results;
  }

  @Override
  @Transactional
  public void updateProductStats() {
    List<Product> products = productRepository.findAll();

    // Initialize a list to store CompletableFuture objects for tracking
    // asynchronous tasks
    List<CompletableFuture<Void>> futures = new ArrayList<>();

    // Create a fixed thread pool with 3 threads to process tasks in parallel
    ExecutorService executor = Executors.newFixedThreadPool(3);

    for (Product product : products) {
      // Create an asynchronous task for each product using CompletableFuture
      CompletableFuture<Void> future = CompletableFuture.runAsync(() -> {
        UUID productId = product.getId();

        // Calculate the average rating for the product, default to 0.0 if no ratings
        // exist
        double rating = ratingRepository.getAverageRatingByProductId(productId).orElse(0.0);

        // Calculate the total number of items sold for the product, default to 0 if
        // none sold
        int sold = orderItemRepo.countByProductId(productId).orElse(0L).intValue();

        product.setRating(rating);
        product.setSold(sold);
      }, executor); // Specify the thread pool to execute the task

      // Add the CompletableFuture to the list for tracking
      futures.add(future);
    }

    try {
      // Wait for all asynchronous tasks to complete
      CompletableFuture.allOf(futures.toArray(new CompletableFuture[0])).join();
      productRepository.saveAll(products);
    } catch (NullPointerException | IllegalArgumentException e) {
      // Handle exceptions that may occur during the execution of CompletableFuture
      // tasks
      log.error("Error occurred while updating product statistics: {}", e.getMessage());
    } finally {
      executor.shutdown(); // Ensure the thread pool is terminated
    }
  }

  @Override
  public Product findById(UUID productId) {
    return productRepository.findById(productId)
        .orElseThrow(() -> new ResourceNotFoundException("Product with id " + productId + " not found"));
  }

  @Override
  public ProductSummaryResponse getProductById(UUID productId) {
    Product product = findById(productId);
    ProductSummaryResponse productSummary = productMapper.toProductSummary(product);
    return productSummary;
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
  public PageResponse<List<ProductSummaryResponse>> searchProductsByKeyword(String keyword, Pageable pageable) {
    log.info("Searching products with keyword: {}", keyword);
    Page<Product> productsPage = productRepository.searchProductsByKeyword(keyword, pageable);
    List<Product> products = productsPage.getContent();
    List<ProductSummaryResponse> productDTOs = productMapper.toProductSummaries(products);

    return PageResponse.<List<ProductSummaryResponse>>builder()
        .currentPage(productsPage.getNumber() + 1)
        .totalPage(productsPage.getTotalPages())
        .data(productDTOs)
        .build();
  }

  @Override
  public PageResponse<List<ProductSummaryResponse>> filterProducts(ProductFilterDTO filterDTO, Pageable pageable) {
    log.info("Filtering products with parameters: {}", filterDTO);

    // Tạo pageable với sort options từ filterDTO
    Pageable pageableWithSort;
    if (filterDTO.getSortOption() != null) {
      pageableWithSort = PageRequest.of(
          pageable.getPageNumber(),
          pageable.getPageSize(),
          filterDTO.getSort());
    } else {
      pageableWithSort = pageable;
    }

    Page<Product> productsPage = productRepository.filterProducts(
        filterDTO.getCategoryIds(),
        filterDTO.getMinPrice(),
        filterDTO.getMaxPrice(),
        filterDTO.getMinRating(),
        pageableWithSort);

    List<Product> products = productsPage.getContent();
    List<ProductSummaryResponse> productDTOs = productMapper.toProductSummaries(products);

    return PageResponse.<List<ProductSummaryResponse>>builder()
        .currentPage(productsPage.getNumber() + 1)
        .totalPage(productsPage.getTotalPages())
        .data(productDTOs)
        .build();
  }

  @Override
  public PageResponse<List<ProductSummaryResponse>> searchAndFilterProducts(
      String keyword, ProductFilterDTO filterDTO, Pageable pageable) {
    log.info("Searching and filtering products with keyword: {} and parameters: {}", keyword, filterDTO);

    // Tạo pageable với sort options từ filterDTO
    Pageable pageableWithSort;
    if (filterDTO.getSortOption() != null) {
      pageableWithSort = PageRequest.of(
          pageable.getPageNumber(),
          pageable.getPageSize(),
          filterDTO.getSort());
    } else {
      pageableWithSort = pageable;
    }

    // Thực hiện search và filter với repository
    Page<Product> productsPage = productRepository.searchAndFilterProducts(
        keyword,
        filterDTO.getCategoryIds(),
        filterDTO.getMinPrice(),
        filterDTO.getMaxPrice(),
        filterDTO.getMinRating(),
        pageableWithSort);

    List<Product> products = productsPage.getContent();
    List<ProductSummaryResponse> productDTOs = productMapper.toProductSummaries(products);

    return PageResponse.<List<ProductSummaryResponse>>builder()
        .currentPage(productsPage.getNumber() + 1)
        .totalPage(productsPage.getTotalPages())
        .data(productDTOs)
        .build();
  }

}
