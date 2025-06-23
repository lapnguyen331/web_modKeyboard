package org.modKeyboard.service;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.response.ImageResponse;
import org.modKeyboard.dto.response.PageResponse;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.multipart.MultipartFile;

public interface IMediaService {
  ImageResponse uploadImage(MultipartFile file);

  PageResponse<List<ImageResponse>> getImages(PageRequest pageable);

  List<ImageResponse> getImagesByProductId(UUID productId);

}
