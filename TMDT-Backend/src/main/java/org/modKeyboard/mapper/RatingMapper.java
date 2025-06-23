package org.modKeyboard.mapper;

import java.util.List;

import org.modKeyboard.dto.response.CommentResponse;
import org.modKeyboard.dto.response.rating.RatingResponse;
import org.modKeyboard.entity.Rating;
import org.springframework.stereotype.Component;

@Component
public class RatingMapper {
  public RatingResponse toResponse(Rating rating) {
    var author = new CommentResponse.Author(rating.getUser().getId(), rating.getUser().getFullName());
    return new RatingResponse(
        rating.getId(),
        author,
        rating.getContent(),
        rating.getRating(),
        rating.getCreatedAt());
  }

  public List<RatingResponse> toReponseList(List<Rating> ratings) {
    return ratings.stream().map(this::toResponse).toList();
  }
}
