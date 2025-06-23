package org.modKeyboard.service.impl;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.category.CategoryCreateRequest;
import org.modKeyboard.dto.request.category.CategoryUpdateRequest;
import org.modKeyboard.dto.response.category.CategoryDetailResponse;
import org.modKeyboard.dto.response.category.CategoryResponse;
import org.modKeyboard.entity.Category;
import org.modKeyboard.exception.ResourceNotFoundException;
import org.modKeyboard.mapper.CategoryMapper;
import org.modKeyboard.repository.CategoryRepository;
import org.modKeyboard.service.ICategoryService;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class CategoryService implements ICategoryService {
  CategoryRepository categoryRepository;
  CategoryMapper categoryMapper;

  public CategoryResponse createCategory(CategoryCreateRequest request) {
    var category = categoryMapper.toEntity(request);
    var savedCategory = categoryRepository.save(category);
    return categoryMapper.toResponse(savedCategory);
  }

  @Override
  public List<CategoryResponse> getActiveCategories() {
    var categoryList = categoryRepository.findAllByIsDeletedFalse();
    return categoryMapper.toResponseList(categoryList);
  }

  @Override
  public List<CategoryResponse> getCategories() {
    var sort = Sort.by(Sort.Direction.DESC, "createdAt");
    var categoryList = categoryRepository.findAll(sort);
    return categoryMapper.toResponseList(categoryList);
  }

  @Override
  public CategoryResponse updateCategory(CategoryUpdateRequest request, UUID id) {
    var currentCategory = categoryRepository
        .findById(id)
        .orElseThrow(() -> ResourceNotFoundException.from("Category with id {} not found", id));
    categoryMapper.updateCategoryFromRequest(request, currentCategory);
    var savedCategory = categoryRepository.save(currentCategory);
    return categoryMapper.toResponse(savedCategory);

  }

  @Override
  public Category getReferenceIfExists(UUID id) {
    if (!categoryRepository.existsById(id))
      throw new ResourceNotFoundException("Category with id " + id + " is not found");
    return categoryRepository.getReferenceById(id);
  }

  @Override
  public void deleteCategory(UUID id) {
    categoryRepository.deleteById(id);
  }

  @Override
  public CategoryDetailResponse getCategoryDetailById(UUID id) {
    return categoryRepository.getCategoryDetailById(id).orElseThrow();
  }

}
