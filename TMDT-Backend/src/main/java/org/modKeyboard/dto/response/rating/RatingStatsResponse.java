package org.modKeyboard.dto.response.rating;

import java.util.Map;

public record RatingStatsResponse(
    int count,
    double averageRating,
    Map<Byte, Long> ratingDistribution) {

}
