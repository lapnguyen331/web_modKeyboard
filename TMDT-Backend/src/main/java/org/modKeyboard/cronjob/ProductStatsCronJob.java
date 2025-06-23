package org.modKeyboard.cronjob;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modKeyboard.service.impl.ProductService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductStatsCronJob {
    private final ProductService productService;


    /**
     Scheduled task that updates product statistics at a fixed interval.
     The task runs every 20 minutes (1,200,000 milliseconds).
     Logs the update time upon success or logs an error message if an exception occurs.
     */
    @Scheduled(fixedRate = 1200000)
    public void updateProductStats() {
        try {
            productService.updateProductStats();
            log.info("Updated product stats at {}", new Timestamp(System.currentTimeMillis()));
        } catch (Exception e) {
            log.error("Error updating product stats: {}", e.getMessage());
        }
    }
}
