package org.modKeyboard.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.modKeyboard.dto.request.rating.RatingCreateRequest;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.rating.RatingResponse;
import org.modKeyboard.dto.response.rating.RatingStatsResponse;
import org.modKeyboard.entity.Rating;
import org.modKeyboard.entity.User;
import org.modKeyboard.mapper.RatingMapper;
import org.modKeyboard.repository.OrderRepository;
import org.modKeyboard.repository.RatingRepository;
import org.modKeyboard.service.IRatingService;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class RatingService implements IRatingService {
  private final RatingRepository ratingRepository;
  private final RatingMapper ratingMapper;
  private final ProductService productService;
  private final OrderRepository orderRepository;

  @Override
  public PageResponse<List<RatingResponse>> getRatings(PageRequest pageable, int ratingFilter, UUID productId) {
    var ratingPage = ratingRepository.findByProductId(productId, pageable);
    if (ratingFilter > 0) {
      ratingPage = ratingRepository.findByProductIdAndRating(productId, (byte) ratingFilter, pageable);
    }
    var ratings = ratingPage.getContent();
    var ratingResponses = ratingMapper.toReponseList(ratings);
    return PageResponse.<List<RatingResponse>>builder()
        .currentPage(ratingPage.getNumber() + 1)
        .totalPage(ratingPage.getTotalPages())
        .data(ratingResponses)
        .build();
  }

  @Override
  public void createRating(RatingCreateRequest request, UUID userId) {
    var product = productService.findById(request.productId());
    var user = new User(userId);
    var rating = new Rating();
    rating.setProduct(product);
    rating.setContent(request.content());
    rating.setRating(request.rating());
    rating.setUser(user);
    ratingRepository.save(rating);
  }

  @Override
  public RatingStatsResponse getRatingStatsResponse(UUID productId) {
    var ratingList = ratingRepository.findByProductId(productId);
    var averageRating = ratingList.stream().mapToInt(Rating::getRating).average().orElse(0.0);
    var count = ratingList.size();
    Map<Byte, Long> ratingDistribution = new HashMap<>();
    for (Byte i = 1; i <= 5; i++)
      ratingDistribution.put(i, 0L);
    var grouped = ratingList.stream()
        .collect(Collectors.groupingBy(Rating::getRating, Collectors.counting()));
    grouped.forEach((k, v) -> ratingDistribution.put(k, v));
    return new RatingStatsResponse(count, averageRating, ratingDistribution);
  }

  @Override
  public int canRateProduct(UUID productId, UUID userId) {
    boolean boughtProduct = orderRepository.existsByUserIdAndProductId(userId, productId);
    boolean ratedByUser = ratingRepository.existsByUserIdAndProductId(userId, productId);
    if (!boughtProduct)
      return 0;
    if (ratedByUser)
      return 2;
    return 1;
  }

}
