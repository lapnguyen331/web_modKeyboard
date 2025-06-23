package org.modKeyboard.mapper;

import org.modKeyboard.dto.CartItemDTO;
import org.modKeyboard.dto.OrderDTO;
import org.modKeyboard.dto.request.PlaceOrderRequest;
import org.modKeyboard.dto.response.order.OrderDetailResponse;
import org.modKeyboard.dto.response.order.OrderSummaryResponse;
import org.modKeyboard.dto.response.order.OrderItemSummary;
import org.modKeyboard.dto.response.order.CustomerInfo;
import org.modKeyboard.entity.Order;
import org.modKeyboard.entity.OrderItem;
import org.modKeyboard.entity.Payment;
import org.modKeyboard.entity.Product;
import org.modKeyboard.entity.User;
import org.springframework.stereotype.Component;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Component
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class OrderMapper {
  PaymentMapper paymentMapper;
  ProductMapper productMapper;

  public List<OrderSummaryResponse> toOrderSummaryResponseList(List<Payment> payments) {
    return payments.stream().map(this::toOrderSummaryResponse).toList();
  }

  public OrderSummaryResponse toOrderSummaryResponse(Payment payment) {
    var order = payment.getOrder();
    return new OrderSummaryResponse(
        order.getId(),
        order.getFullName(),
        order.getPhoneNumber(),
        order.getTotalAmount(),
        order.getStatus(),
        paymentMapper.toResponse(payment),
        order.getCreatedAt());
  }

  public OrderDTO toDTO(Order order) {
    var orderDTO = OrderDTO
        .builder()
        .id(order.getId())
        .fullName(order.getFullName())
        .phoneNumber(order.getPhoneNumber())
        .street(order.getStreet())
        .province(order.getProvince())
        .district(order.getDistrict())
        .commune(order.getCommune())
        .note(order.getNote())
        .totalAmount(order.getTotalAmount())
        .build();
    return orderDTO;
  }

  public Order toEntity(OrderDTO orderDTO) {
    return null;
  }

  public Order toEntity(PlaceOrderRequest request) {
    var order = new Order();
    order.setFullName(request.getFullName());
    order.setPhoneNumber(request.getPhoneNumber());
    order.setStreet(request.getStreet());
    order.setProvince(request.getProvince());
    order.setDistrict(request.getDistrict());
    order.setCommune(request.getCommune());
    order.setNote(request.getNote());
    return order;
  }

  public OrderItem toItemEntity(CartItemDTO cartItem) {
    var orderItem = OrderItem
        .builder()
        .product(new Product(cartItem.product().id()))
        .productName(cartItem.product().name())
        .price(cartItem.product().price())
        .quantity(cartItem.quantity())
        .build();
    return orderItem;
  }

  public List<OrderItem> toItemEntities(List<CartItemDTO> cartByUser) {
    return cartByUser
        .stream()
        .map(this::toItemEntity).toList();
  }

  public OrderItemSummary toOrderItemResponse(OrderItem orderItem) {
    var product = productMapper.toProductSummary(orderItem.getProduct());
    return new OrderItemSummary(
        orderItem.getPrice(),
        orderItem.getQuantity(),
        product);
  }

  public List<OrderItemSummary> toOrderItemResponseList(List<OrderItem> orderItems) {
    return orderItems.stream().map(this::toOrderItemResponse).toList();
  }

  public OrderDetailResponse toOrderDetailResponse(Order order, Payment payment, User customer, String address) {
    var orderItems = toOrderItemResponseList(order.getOrderItems());
    var customerInfo = toCustomerInfo(customer);
    return new OrderDetailResponse(
        toOrderSummaryResponse(payment),
        orderItems,
        customerInfo,
        order.getStreet(),
        order.getNote(),
        address,
        order.getFullName(),
        order.getCreatedAt());
  }

  public CustomerInfo toCustomerInfo(User customer) {
    return new CustomerInfo(
        customer.getId(),
        customer.getFullName(),
        customer.getPhone(),
        customer.getEmail());
  }

}
