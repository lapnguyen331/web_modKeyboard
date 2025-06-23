package org.modKeyboard.service;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.rating.RatingCreateRequest;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.rating.RatingResponse;
import org.modKeyboard.dto.response.rating.RatingStatsResponse;
import org.springframework.data.domain.PageRequest;

public interface IRatingService {

  PageResponse<List<RatingResponse>> getRatings(PageRequest pageable, int rating, UUID productId);

  void createRating(RatingCreateRequest request, UUID userId);

  RatingStatsResponse getRatingStatsResponse(UUID productId);

  int canRateProduct(UUID productId, UUID id);

}
