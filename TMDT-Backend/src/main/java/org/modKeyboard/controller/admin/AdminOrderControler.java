package org.modKeyboard.controller.admin;

import org.springframework.web.bind.annotation.RestController;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.order.OrderUpdateRequest;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.dto.response.order.OrderDetailResponse;
import org.modKeyboard.dto.response.order.OrderSummaryResponse;
import org.modKeyboard.service.IOrderService;
import org.hibernate.validator.constraints.Range;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@Validated
@RequestMapping("${API_PREFIX}/admin/orders")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class AdminOrderControler {
  IOrderService orderService;

  @PutMapping("/{orderId}")
  public ResponseObject<Void> updateOrderStatus(@PathVariable UUID orderId,
      @RequestBody OrderUpdateRequest request) {
    orderService.updateOrderStatus(orderId, request);
    return new ResponseObject<>(HttpStatus.OK, "Order status updated successfully");
  }

  @GetMapping("/{orderId}")
  public ResponseObject<OrderDetailResponse> getOrderDetailById(@PathVariable UUID orderId) {
    var response = orderService.getOrderDetailById(orderId);
    return new ResponseObject<>(HttpStatus.OK, "Order detail fetched successfully", response);
  }

  @GetMapping
  public ResponseObject<PageResponse<List<OrderSummaryResponse>>> getOrders(
      @RequestParam(value = "page", defaultValue = "1") @Range(min = 1) int page,
      @RequestParam(value = "size", defaultValue = "10") @Range(min = 1, max = 50) int size) {
    var sort = Sort.by(Sort.Direction.DESC, "paymentDate");
    var pageable = PageRequest.of(page - 1, size, sort);
    var response = orderService.getOrders(pageable);
    return new ResponseObject<>(HttpStatus.OK, response);
  }
}
