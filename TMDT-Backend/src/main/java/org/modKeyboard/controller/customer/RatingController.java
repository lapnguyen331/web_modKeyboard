package org.modKeyboard.controller.customer;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.CustomUserSecurity;
import org.modKeyboard.dto.request.rating.RatingCreateRequest;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.dto.response.rating.RatingResponse;
import org.modKeyboard.dto.response.rating.RatingStatsResponse;
import org.modKeyboard.service.IRatingService;
import org.hibernate.validator.constraints.Range;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("${API_PREFIX}")
@RequiredArgsConstructor
public class RatingController {
  private final IRatingService ratingService;

  @GetMapping("/products/{productId}/rating-stats")
  public ResponseObject<RatingStatsResponse> getRatingStats(
      @PathVariable UUID productId) {
    var response = ratingService.getRatingStatsResponse(productId);
    return new ResponseObject<>(HttpStatus.OK, response);

  }

  @GetMapping("/ratings/products/{productId}/check-eligibility")
  public ResponseObject<Integer> canRateProduct(
      @PathVariable UUID productId,
      @AuthenticationPrincipal CustomUserSecurity user) {
    var response = ratingService.canRateProduct(productId, user.getId());
    return new ResponseObject<>(HttpStatus.OK, response);

  }

  @GetMapping("/products/{productId}/ratings")
  public ResponseObject<PageResponse<List<RatingResponse>>> getRatings(
      @PathVariable UUID productId,
      @RequestParam(value = "ratingFilter", defaultValue = "0") @Range(min = 0) int ratingFilter,
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size) {
    var sort = Sort.by(Sort.Direction.DESC, "createdAt");
    var pageable = PageRequest.of(page - 1, size, sort);
    var response = ratingService.getRatings(pageable, ratingFilter, productId);
    return new ResponseObject<>(HttpStatus.OK, response);
  }

  @PostMapping("/ratings")
  public ResponseObject<Void> createRating(@RequestBody @Valid RatingCreateRequest request,
      @AuthenticationPrincipal CustomUserSecurity user) {
    ratingService.createRating(request, user.getId());
    return new ResponseObject<>(HttpStatus.OK, "Rating created");

  }
}
