package org.modKeyboard.util;

import lombok.experimental.UtilityClass;
import org.modKeyboard.dto.CustomUserSecurity;
import org.springframework.security.core.context.SecurityContextHolder;

@UtilityClass
public class UserSecurityHelper {
    public CustomUserSecurity getCurrentUser() throws ClassCastException{
        return (CustomUserSecurity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }
}
