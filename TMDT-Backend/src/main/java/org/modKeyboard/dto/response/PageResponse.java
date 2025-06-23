package org.modKeyboard.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;


@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PageResponse<T> {
    int totalPage;
    int currentPage;
    T data;

}

//Page<Product> products = productRepository.findAll(pageable);
//List<ProductDTO> dtos = productMapper.toDTOs(products.getContent());
//        dtos.forEach(this::setPrice);

//PageResponse<List<ProductDTO>> results = PageResponse.<List<ProductDTO>>builder()
//        .currentPage(products.getNumber())
//        .totalPage(products.getTotalPages())
//        .data(dtos)
//        .build();