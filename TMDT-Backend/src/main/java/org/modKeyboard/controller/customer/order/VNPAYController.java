
package org.modKeyboard.controller.customer.order;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modKeyboard.dto.CustomUserSecurity;
import org.modKeyboard.dto.OrderDTO;
import org.modKeyboard.dto.enums.PaymentStatus;
import org.modKeyboard.dto.request.PlaceOrderRequest;
import org.modKeyboard.dto.response.OnlinePaymentResponse;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.service.ICartService;
import org.modKeyboard.service.IOrderService;
import org.modKeyboard.service.IVnpayService;
import org.modKeyboard.util.VnpayHelper;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("${API_PREFIX}/orders/vnpay-payment")
@RequiredArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE, makeFinal = true)
public class VNPAYController {
  IOrderService orderService;
  IVnpayService vnpayService;
  ICartService cartService;

  // Example URL for testing:
  // http://localhost:5173/thanh-toan?payment=vnpay&
  // orderId=64492741-6e29-4836-b083-80e0fcca2983&
  // vnp_Amount=1000000000&
  // vnp_BankCode=NCB
  // &vnp_BankTranNo=VNP14933906&
  // vnp_CardType=ATM&
  // vnp_OrderInfo=Thanh+toan+don+hang%3A75497360&
  // vnp_PayDate=20250501195247&
  // vnp_ResponseCode=00
  // &vnp_TmnCode=25EY8DAW&
  // vnp_TransactionNo=14933906&
  // vnp_TransactionStatus=00&
  // vnp_TxnRef=24721759&
  // vnp_SecureHash=ccd105c447

  @PostMapping("/payment-completed")
  public ResponseObject<Void> paymentCompleted(HttpServletRequest request,
      @AuthenticationPrincipal CustomUserSecurity user) {

    Map<String, String> fields = VnpayHelper.getParamsFromRequest(request);

    String ipAddress = VnpayHelper.getIpAddress(request);
    UUID orderId = UUID.fromString(fields.get("orderId"));
    try {
      boolean isPaymentSuccessful = vnpayService.processPaymentResponse(fields, ipAddress);

      if (isPaymentSuccessful) {
        // change order status to PAID
        orderService.updatePaymentStatus(orderId, PaymentStatus.COMPLETED);

        // clear cart
        cartService.clearCart(user.getId());

        return new ResponseObject<>(HttpStatus.OK);
      } else {
        // remove order by id
        orderService.deleteOrder(orderId);

        return new ResponseObject<>(HttpStatus.BAD_REQUEST, "Transaction failed");
      }
    } catch (Exception e) {
      // remove order by id
      orderService.deleteOrder(orderId);
      return new ResponseObject<>(HttpStatus.BAD_REQUEST, "Transaction failed");
    }
  }

  /**
   * Handles checkout by creating an order and generating a VNPAY payment URL.
   *
   * @param orderRequest The order details from the client.
   * @param user         The authenticated user.
   * @param request      The HTTP request for retrieving the client's IP.
   * @return A response containing the VNPAY payment URL.
   */
  @PostMapping("/submit-order")
  public ResponseObject<OnlinePaymentResponse> submitOrder(@RequestBody PlaceOrderRequest orderRequest,
      @AuthenticationPrincipal CustomUserSecurity user,
      HttpServletRequest request) {

    // Save the order and get the saved order
    OrderDTO order = orderService.saveOrderNotPayment(orderRequest, user.getId());

    String ipAddress = VnpayHelper.getIpAddress(request);
    String paymentUrl = vnpayService.generatePaymentUrl(order, ipAddress);

    OnlinePaymentResponse response = OnlinePaymentResponse.builder()
        .paymentUrl(paymentUrl)
        .build();

    return new ResponseObject<>(HttpStatus.OK, response);
  }
}
