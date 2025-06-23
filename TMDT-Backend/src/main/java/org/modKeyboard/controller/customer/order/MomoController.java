
package org.modKeyboard.controller.customer.order;

import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modKeyboard.dto.CustomUserSecurity;
import org.modKeyboard.dto.OrderDTO;
import org.modKeyboard.dto.enums.PaymentStatus;
import org.modKeyboard.dto.request.MoMoCallback;
import org.modKeyboard.dto.request.PlaceOrderRequest;
import org.modKeyboard.dto.response.OnlinePaymentResponse;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.service.ICartService;
import org.modKeyboard.service.IMomoService;
import org.modKeyboard.service.IOrderService;
import org.modKeyboard.util.MoMoUtil;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("${API_PREFIX}/orders/momo-payment")
@RequiredArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE, makeFinal = true)
public class MomoController {
    IMomoService momoService;
    IOrderService orderService;
    ICartService cartService;

    @PostMapping("/submit-order")
    public ResponseObject<OnlinePaymentResponse> submitOrder(@RequestBody PlaceOrderRequest orderRequest,
                                                             @AuthenticationPrincipal CustomUserSecurity user) {
        // Save the order and get the saved order
        OrderDTO order = orderService.saveOrderNotPayment(orderRequest, user.getId());

        String paymentUrl = momoService.getPaymentUrl(order);

        OnlinePaymentResponse response = OnlinePaymentResponse.builder()
                .paymentUrl(paymentUrl)
                .build();

        return new ResponseObject<>(HttpStatus.OK, response);

    }

    @PostMapping("/payment-completed")
    public ResponseObject<Void> paymentCompleted(@RequestBody MoMoCallback callback,
                                                 @AuthenticationPrincipal CustomUserSecurity user) {
        // Example callback data
        // http://localhost:5173/thanh-toan?payment=momo&partnerCode=MOMOBKUN20180529&orderId=fa839a45-a04b-4760-b523-9a2270c20c36&requestId=09733aba-b767-49f8-8145-6114daeff192&amount=10000000&orderInfo=Thanh+to%C3%A1n+%C4%91%C6%A1n+h%C3%A0ng+fa839a45-a04b-4760-b523-9a2270c20c36&orderType=momo_wallet&transId=4415707100&resultCode=0&message=Successful.&payType=napas&responseTime=1746525771203&extraData=&signature=359b082bca62171a1901aa8c1ba7ee25a90599ff010c0e06568887821504448b
        if (callback.getResultCode() != MoMoUtil.SUCCESS_CODE) {
            return new ResponseObject<>(HttpStatus.BAD_REQUEST, "Transaction failed");
        }

        UUID orderId = UUID.fromString(callback.getOrderId());

        boolean isPaymentSuccessful = momoService.checkPaymentStatus(callback);
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
    }

}
