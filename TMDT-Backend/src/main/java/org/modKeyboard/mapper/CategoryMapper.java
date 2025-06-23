package org.modKeyboard.mapper;

import java.util.List;

import org.modKeyboard.dto.request.category.CategoryCreateRequest;
import org.modKeyboard.dto.request.category.CategoryUpdateRequest;
import org.modKeyboard.dto.response.category.CategoryResponse;
import org.modKeyboard.entity.Category;
import org.springframework.stereotype.Component;

@Component
public class CategoryMapper {

  public CategoryResponse toResponse(Category category) {
    return new CategoryResponse(
        category.getId(),
        category.getName(),
        category.isDeleted(),
        category.getDescription(),
        category.getCreatedAt());
  }

  public List<CategoryResponse> toResponseList(List<Category> categoryList) {
    return categoryList.stream().map(this::toResponse).toList();

  }

  public void updateCategoryFromRequest(CategoryUpdateRequest request, Category category) {
    category.setDescription(request.description());
    category.setName(request.name());
    category.setDeleted(request.isDeleted());
  }

  public Category toEntity(CategoryCreateRequest request) {
    var category = new Category();
    category.setName(request.name());
    category.setDescription(request.description());
    return category;
  }

}
