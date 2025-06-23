package org.modKeyboard.service;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.product.ProductFilterDTO;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.ProductDetailResponse;
import org.modKeyboard.dto.response.ProductSummaryResponse;
import org.modKeyboard.entity.Product;
import org.springframework.data.domain.Pageable;

public interface IProductService {
  /**
   * Retrieves a list of the newest products as ProductDetailResponse objects.
   * 
   * @param pageable the pagination information
   * @return a list of ProductDetailResponse objects representing the newest
   *         products
   */
  List<ProductSummaryResponse> getNewestProducts(Pageable pageable);

  /**
   * Retrieves a list of the best-selling products as ProductDetailResponse
   * objects.
   * 
   * @param pageable the pagination information
   * @return a list of ProductDetailResponse objects representing the best-selling
   *         products
   */
  List<ProductSummaryResponse> getBestSellerProducts(Pageable pageable);

  /**
   * Retrieves a list of the most viewed products as ProductDetailResponse
   * objects.
   * 
   * @param pageable the pagination information
   * @return a list of ProductDetailResponse objects representing the most viewed
   *         products
   */
  List<ProductSummaryResponse> getMostViewedProducts(Pageable pageable);

  /**
   * Updates product statistics, such as sales and rating, in the system.
   * This method is typically invoked by a scheduled task to ensure
   * product statistics remain up-to-date.
   */
  void updateProductStats();

  Product findById(UUID productId);

  ProductSummaryResponse getProductById(UUID productId);

  ProductDetailResponse getProductDetail(UUID productId);

  PageResponse<List<ProductSummaryResponse>> searchProductsByKeyword(String keyword, Pageable pageable);

  PageResponse<List<ProductSummaryResponse>> filterProducts(ProductFilterDTO filterDTO, Pageable pageable);

  PageResponse<List<ProductSummaryResponse>> searchAndFilterProducts(String keyword, ProductFilterDTO filterDTO,
      Pageable pageable);

}
