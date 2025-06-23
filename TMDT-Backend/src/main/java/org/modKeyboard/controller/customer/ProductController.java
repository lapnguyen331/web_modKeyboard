package org.modKeyboard.controller.customer;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.product.ProductFilterDTO;
import org.modKeyboard.dto.response.CommentResponse;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.ProductDetailResponse;
import org.modKeyboard.dto.response.ProductSummaryResponse;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.service.ICommentService;
import org.modKeyboard.service.IProductService;
import org.hibernate.validator.constraints.Range;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController("CustomerProductController")
@RequestMapping("${API_PREFIX}/products")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class ProductController {
  IProductService productService;
  ICommentService commentService;

  @GetMapping("/newest")
  public ResponseObject<List<ProductSummaryResponse>> getNewestProducts(
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size) {
    Sort sort = Sort.by("createdAt").descending();
    Pageable pageable = PageRequest.of(page - 1, size, sort);
    List<ProductSummaryResponse> products = productService.getNewestProducts(pageable);
    return new ResponseObject<>(HttpStatus.OK, products);
  }

  @GetMapping("/best-seller")
  public ResponseObject<List<ProductSummaryResponse>> getBestSellerProducts(
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size) {
    Pageable pageable = PageRequest.of(page - 1, size);
    List<ProductSummaryResponse> products = productService.getBestSellerProducts(pageable);
    return new ResponseObject<>(HttpStatus.OK, products);
  }

  @GetMapping("/most-viewed")
  public ResponseObject<List<ProductSummaryResponse>> getMostViewedProducts(
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size) {
    Sort sort = Sort.by("totalViews").descending();
    Pageable pageable = PageRequest.of(page - 1, size, sort);
    List<ProductSummaryResponse> products = productService.getMostViewedProducts(pageable);
    return new ResponseObject<>(HttpStatus.OK, products);
  }

  @GetMapping("/{productId}")
  public ResponseObject<ProductDetailResponse> getProductDetail(
      @PathVariable UUID productId) {
    var productDetail = productService.getProductDetail(productId);
    return new ResponseObject<>(HttpStatus.OK, productDetail);
  }

  @GetMapping("/quick-search")
  public ResponseObject<PageResponse<List<ProductSummaryResponse>>> quickSearch(
      @RequestParam(value = "q", required = false) String keyword,
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size) {

    Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
    Pageable pageable = PageRequest.of(page - 1, size, sort);

    PageResponse<List<ProductSummaryResponse>> pageResponse = productService.searchProductsByKeyword(keyword, pageable);
    return new ResponseObject<>(HttpStatus.OK, pageResponse);
  }

  @GetMapping("/{productId}/comments")
  public ResponseObject<PageResponse<List<CommentResponse>>> getComments(
      @PathVariable UUID productId,
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size) {
    var sort = Sort.by(Sort.Direction.DESC, "createdAt");
    var pageable = PageRequest.of(page - 1, size, sort);
    var response = commentService.getCommentsWithReplies(pageable, productId);
    return new ResponseObject<>(HttpStatus.OK, response);
  }

  @PostMapping("/filter")
  public ResponseObject<PageResponse<List<ProductSummaryResponse>>> filterProducts(
      @RequestBody ProductFilterDTO filterDTO,
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size) {

    Pageable pageable = PageRequest.of(page - 1, size);
    PageResponse<List<ProductSummaryResponse>> pageResponse = productService.filterProducts(filterDTO, pageable);
    return new ResponseObject<>(HttpStatus.OK, pageResponse);
  }

  @PostMapping("/search-filter")
  public ResponseObject<PageResponse<List<ProductSummaryResponse>>> searchAndFilterProducts(
      @RequestParam(value = "q", required = false) String keyword,
      @RequestBody ProductFilterDTO filterDTO,
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size) {

    Pageable pageable = PageRequest.of(page - 1, size);
    PageResponse<List<ProductSummaryResponse>> pageResponse = productService.searchAndFilterProducts(keyword, filterDTO,
        pageable);
    return new ResponseObject<>(HttpStatus.OK, pageResponse);
  }

}
