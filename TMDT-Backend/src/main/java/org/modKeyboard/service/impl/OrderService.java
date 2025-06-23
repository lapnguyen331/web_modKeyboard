package org.modKeyboard.service.impl;

import java.sql.Timestamp;
import java.text.MessageFormat;
import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.CartItemDTO;
import org.modKeyboard.dto.OrderDTO;
import org.modKeyboard.dto.enums.OrderStatus;
import org.modKeyboard.dto.enums.PaymentMethod;
import org.modKeyboard.dto.enums.PaymentStatus;
import org.modKeyboard.dto.request.PlaceOrderRequest;
import org.modKeyboard.dto.request.order.OrderUpdateRequest;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.dto.response.order.OrderDetailResponse;
import org.modKeyboard.dto.response.order.OrderSummaryResponse;
import org.modKeyboard.entity.Order;
import org.modKeyboard.entity.OrderItem;
import org.modKeyboard.entity.Payment;
import org.modKeyboard.entity.User;
import org.modKeyboard.exception.ResourceNotFoundException;
import org.modKeyboard.mapper.OrderMapper;
import org.modKeyboard.repository.OrderItemRepository;
import org.modKeyboard.repository.OrderRepository;
import org.modKeyboard.repository.PaymentRepository;
import org.modKeyboard.service.ICartService;
import org.modKeyboard.service.IOrderService;
import org.modKeyboard.validate.Validator;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OrderService implements IOrderService {
  ICartService cartService;
  OrderMapper orderMapper;
  OrderRepository orderRepository;
  PaymentRepository paymentRepository;
  OrderItemRepository orderItemRepository;

  /**
   * Saves an order without payment, creating associated payment and order items.
   */
  @Override
  @Transactional
  public OrderDTO saveOrderNotPayment(PlaceOrderRequest orderRequest, UUID userId) {
    if (!Validator.isValidPhoneNumber(orderRequest.getPhoneNumber())) {
      throw new IllegalArgumentException("Invalid phone number");
    }

    List<CartItemDTO> cartItems = validateAndGetCart(userId);
    double totalAmount = calculateTotalAmount(cartItems);

    Order order = createOrder(orderRequest, userId, totalAmount);
    orderRepository.save(order);

    createAndSavePayment(order, orderRequest.getPaymentMethod());

    // Save order items
    saveOrderItems(cartItems, order);

    return orderMapper.toDTO(order);
    // return
    // OrderDTO.builder().id(UUID.randomUUID()).totalAmount(10000000).build();
  }

  @Override
  public void updatePaymentStatus(UUID orderId, PaymentStatus paymentStatus) {
    Payment payment = paymentRepository.findByOrderId(orderId)
        .orElseThrow(() -> new ResourceNotFoundException("Payment not found for order ID: " + orderId));

    payment.setStatus(paymentStatus);

    paymentRepository.save(payment);

  }

  @Override
  public void deleteOrder(UUID orderId) {
    Order order = findByIdOrThrow(orderId);
    // Delete associated order items
    List<OrderItem> orderItems = orderItemRepository.findAll(Example.of(OrderItem.builder().order(order).build()));
    orderItemRepository.deleteAll(orderItems);

    // Delete associated payment
    Payment payment = paymentRepository.findByOrderId(orderId)
        .orElseThrow(() -> new ResourceNotFoundException("Payment not found for order ID: " + orderId));
    paymentRepository.delete(payment);

    // Delete the order itself
    orderRepository.delete(order);
  }

  private List<CartItemDTO> validateAndGetCart(UUID userId) {
    List<CartItemDTO> cartItems = cartService.getCartByUser(userId);
    if (cartItems.isEmpty()) {
      throw new IllegalStateException("Cannot place order: Cart is empty");
    }
    return cartItems;
  }

  private double calculateTotalAmount(List<CartItemDTO> cartItems) {
    return cartItems.stream()
        .mapToDouble(item -> {
          double price = item.product().price();
          double discountPrice = item.product().discountPrice();
          return (discountPrice > 0 ? discountPrice : price) * item.quantity();
        })
        .sum();
  }

  private Order createOrder(PlaceOrderRequest orderRequest, UUID userId, double totalAmount) {
    Order order = orderMapper.toEntity(orderRequest);
    order.setUser(new User(userId));
    order.setCreatedAt(new Timestamp(System.currentTimeMillis()));
    order.setTotalAmount(totalAmount);
    order.setStatus(OrderStatus.PENDING);
    return order;
  }

  private Payment createAndSavePayment(Order order, String paymentMethodValue) {
    PaymentMethod paymentMethod = PaymentMethod.fromValue(paymentMethodValue);
    Payment payment = Payment.builder()
        .method(paymentMethod)
        .paymentDate(new Timestamp(System.currentTimeMillis()))
        .order(order)
        .status(PaymentStatus.UNPAID)
        .build();
    return paymentRepository.save(payment);
  }

  private void saveOrderItems(List<CartItemDTO> cartItems, Order order) {
    List<OrderItem> orderItems = orderMapper.toItemEntities(cartItems);
    orderItems.forEach(item -> {
      item.setOrder(order);
    });
    orderItemRepository.saveAll(orderItems);
  }

  @Override
  public PageResponse<List<OrderSummaryResponse>> getOrders(Pageable pageable) {
    var page = paymentRepository.findAll(pageable);
    var paymentList = page.getContent();
    var orderSummaryResponseList = orderMapper.toOrderSummaryResponseList(paymentList);
    return PageResponse.<List<OrderSummaryResponse>>builder()
        .currentPage(page.getNumber() + 1)
        .totalPage(page.getTotalPages())
        .data(orderSummaryResponseList)
        .build();

  }

  @Override
  public void updateOrderStatus(UUID orderId, OrderUpdateRequest request) {
    var currentOrder = findByIdOrThrow(orderId);
    if (!Validator.validateOrderUpdateStatus(currentOrder.getStatus(), request.status()))
      throw new IllegalArgumentException("Update order status request is not valid");
    currentOrder.setStatus(request.status());
    orderRepository.save(currentOrder);
  }

  @Override
  public Order findByIdOrThrow(UUID orderId) {
    return orderRepository.findById(orderId)
        .orElseThrow(() -> ResourceNotFoundException.from("Order not found with ID: {}", orderId));
  }

  @Override
  public OrderDetailResponse getOrderDetailById(UUID orderId) {
    var order = findByIdOrThrow(orderId);
    var payment = paymentRepository.findByOrderId(orderId)
        .orElseThrow(() -> new ResourceNotFoundException("Payment not found for order ID: " + orderId));
    var customer = order.getUser();
    String address = MessageFormat.format("{0}, {1}, {2}",
        order.getCommune(), order.getDistrict(), order.getProvince());
    return orderMapper.toOrderDetailResponse(order, payment, customer, address);
  }

}
