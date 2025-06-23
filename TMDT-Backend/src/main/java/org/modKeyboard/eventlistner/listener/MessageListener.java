package org.modKeyboard.eventlistner.listener;

import org.modKeyboard.dto.response.AppNotificationResponse;
import org.modKeyboard.eventlistner.event.CartEvent;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import lombok.AccessLevel;

@Service
@AllArgsConstructor
@Slf4j
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
@ConditionalOnProperty(name = "websocket.enabled", havingValue = "true", matchIfMissing = false)
public class MessageListener {
  SimpMessagingTemplate messagingTemplate;

  @EventListener
  public void broadCastApplicationMessage(CartEvent event) {
    String topic = "/topic/notifications";
    var message = event.cartOwner() + " đang thêm sản phẩm vào giỏ hàng";
    var payload = new AppNotificationResponse(event.userId(), message);
    messagingTemplate.convertAndSend(topic, payload);
  }

}
