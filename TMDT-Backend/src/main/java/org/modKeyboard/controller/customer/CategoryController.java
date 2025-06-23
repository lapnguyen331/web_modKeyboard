package org.modKeyboard.controller.customer;

import java.util.List;

import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.dto.response.category.CategoryResponse;
import org.modKeyboard.service.ICategoryService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController("CategoryController")
@RequestMapping("${API_PREFIX}/categories")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class CategoryController {
  ICategoryService categoryService;

  @GetMapping
  public ResponseObject<List<CategoryResponse>> getActiveCategories() {
    var categories = categoryService.getActiveCategories();
    return new ResponseObject<>(HttpStatus.OK, categories);
  }

}
