package org.modKeyboard.controller.admin;

import java.util.List;

import org.modKeyboard.dto.response.ImageResponse;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.service.IMediaService;
import org.hibernate.validator.constraints.Range;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import lombok.AccessLevel;

@RestController("AdminMediaController")
@RequestMapping("${API_PREFIX}/admin/media")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class MediaController {
  IMediaService mediaService;

  @PostMapping("/upload")
  public ResponseObject<ImageResponse> uploadImage(@RequestParam("file") MultipartFile file) {
    var response = mediaService.uploadImage(file);
    return new ResponseObject<>(HttpStatus.OK, response);
  }

  @GetMapping
  public ResponseObject<PageResponse<List<ImageResponse>>> getImages(
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size) {
    var sort = Sort.by(Sort.Direction.DESC, "uploadedAt");
    var pageable = PageRequest.of(page - 1, size, sort);
    var pageResponse = mediaService.getImages(pageable);
    return new ResponseObject<>(HttpStatus.OK, pageResponse);
  }
}
