package org.modKeyboard.controller.admin;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.category.CategoryCreateRequest;
import org.modKeyboard.dto.request.category.CategoryUpdateRequest;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.dto.response.category.CategoryDetailResponse;
import org.modKeyboard.dto.response.category.CategoryResponse;
import org.modKeyboard.service.ICategoryService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController("AdminCategoryController")
@RequestMapping("${API_PREFIX}/admin/categories")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class AdminCategoryController {
  ICategoryService categoryService;

  @PutMapping("/{id}")
  public ResponseObject<CategoryResponse> updateCategory(@RequestBody CategoryUpdateRequest request,
      @PathVariable UUID id) {
    var response = categoryService.updateCategory(request, id);
    return new ResponseObject<>(HttpStatus.OK, response);
  }

  @DeleteMapping("/{id}")
  public ResponseObject<Void> deleteCategory(@PathVariable UUID id) {
    categoryService.deleteCategory(id);
    return new ResponseObject<>(HttpStatus.OK);
  }

  @PostMapping()
  public ResponseObject<CategoryResponse> createCategory(@RequestBody CategoryCreateRequest request) {
    var response = categoryService.createCategory(request);
    return new ResponseObject<>(HttpStatus.OK, response);
  }

  @GetMapping("/{id}/detail")
  public ResponseObject<CategoryDetailResponse> getCategoryDetailById(@PathVariable("id") UUID id) {
    var response = categoryService.getCategoryDetailById(id);
    return new ResponseObject<>(HttpStatus.OK, response);
  }

  @GetMapping()
  public ResponseObject<List<CategoryResponse>> getCategories() {
    var categories = categoryService.getCategories();
    return new ResponseObject<>(HttpStatus.OK, categories);
  }

}
