package org.modKeyboard.service;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.category.CategoryCreateRequest;
import org.modKeyboard.dto.request.category.CategoryUpdateRequest;
import org.modKeyboard.dto.response.category.CategoryDetailResponse;
import org.modKeyboard.dto.response.category.CategoryResponse;
import org.modKeyboard.entity.Category;

public interface ICategoryService {
  List<CategoryResponse> getCategories();

  Category getReferenceIfExists(UUID id);

  CategoryResponse createCategory(CategoryCreateRequest request);

  CategoryResponse updateCategory(CategoryUpdateRequest request, UUID id);

  void deleteCategory(UUID id);

  List<CategoryResponse> getActiveCategories();

  CategoryDetailResponse getCategoryDetailById(UUID id);
}
