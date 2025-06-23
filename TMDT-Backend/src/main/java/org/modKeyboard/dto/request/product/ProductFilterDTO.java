package org.modKeyboard.dto.request.product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.domain.Sort;

import java.util.List;
import java.util.UUID;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProductFilterDTO {
    // Lọc theo category
    private List<UUID> categoryIds;

    // Lọc theo khoảng giá
    private Double minPrice;
    private Double maxPrice;

    // Lọc theo rating
    private Double minRating;

    // Sắp xếp
    private SortOption sortOption;
    private SortDirection sortDirection;

    // Enum cho các tùy chọn sắp xếp
    public enum SortOption {
        NEWEST("createdAt"),
        BEST_SELLER("sold"),
        PRICE("price"),
        MOST_VIEWED("totalViews");

        private final String field;

        SortOption(String field) {
            this.field = field;
        }

        public String getField() {
            return field;
        }
    }

    // Enum cho hướng sắp xếp
    public enum SortDirection {
        ASC(Sort.Direction.ASC),
        DESC(Sort.Direction.DESC);

        private final Sort.Direction direction;

        SortDirection(Sort.Direction direction) {
            this.direction = direction;
        }

        public Sort.Direction getDirection() {
            return direction;
        }
    }

    // Method để tạo Sort object từ các tùy chọn sắp xếp
    public Sort getSort() {
        SortOption option = sortOption != null ? sortOption : SortOption.NEWEST;
        SortDirection direction = sortDirection != null ? sortDirection : SortDirection.DESC;

        return Sort.by(direction.getDirection(), option.getField());
    }
}