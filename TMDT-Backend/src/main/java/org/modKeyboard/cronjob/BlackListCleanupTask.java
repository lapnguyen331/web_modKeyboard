package org.modKeyboard.cronjob;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modKeyboard.service.ITokenService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class BlackListCleanupTask {
    private final ITokenService tokenService;

    @Scheduled(fixedRate = 1200000) // 20 minutes
    private void deleteExpiredTokens() {
        log.info("Running token cleanup task...");
        tokenService.removeExpiredTokens();
    }
}
