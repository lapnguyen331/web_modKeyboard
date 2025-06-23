package org.modKeyboard.service;

import org.modKeyboard.dto.OrderDTO;
import org.modKeyboard.dto.enums.PaymentStatus;
import org.modKeyboard.dto.request.PlaceOrderRequest;
import org.modKeyboard.dto.request.order.OrderUpdateRequest;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.order.OrderDetailResponse;
import org.modKeyboard.dto.response.order.OrderSummaryResponse;
import org.modKeyboard.entity.Order;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.UUID;

public interface IOrderService {

  OrderDTO saveOrderNotPayment(PlaceOrderRequest orderRequest, UUID userId);

  void updatePaymentStatus(UUID orderId, PaymentStatus paymentStatus);

  void deleteOrder(UUID orderId);

  void updateOrderStatus(UUID orderId, OrderUpdateRequest request);

  Order findByIdOrThrow(UUID orderId);

  OrderDetailResponse getOrderDetailById(UUID orderId);

  PageResponse<List<OrderSummaryResponse>> getOrders(Pageable pageable);
}
