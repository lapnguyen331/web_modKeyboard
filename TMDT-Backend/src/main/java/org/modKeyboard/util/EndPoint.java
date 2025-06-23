package org.modKeyboard.util;

import lombok.experimental.UtilityClass;
import org.springframework.util.AntPathMatcher;

@UtilityClass
public class EndPoint {
  private final String[] AUTHENTICATED_ENDPOINTS = new String[] {
      "/api/v1/cart/**",
      "/api/v1/orders/**",
      "/api/v1/comments/**",
      "/api/v1/ratings/**",
      "/api/v1/users/me",
      "/api/v1/auth/logout"
  };

  private final String[] ADMIN_ENDPOINTS = new String[] {
      "/api/v1/admin/revenues/**",
  };

  private final String[] EMPLOYEE_ENDPOINTS = new String[] {
      "/api/v1/admin/categories/**",
      "/api/v1/admin/products/**",
      "/api/v1/admin/media/**",
      "/api/v1/admin/orders/**",
  };

  private final String[] PUBLIC_ENDPOINTS = new String[] {
      "/api/v1/categories/**",
      "/api/v1/products/**",
      "/api/v1/registration/**",
      "/api/v1/users/forgot-password",
      "/api/v1/users/forgot-password-opt",
      "/api/v1/auth/refresh-token",
      "/api/v1/auth/login",
      "/api/v1/auth/google",
      "/ws/**",
  };

  public String[] authenticatedEndpoints() {
    return AUTHENTICATED_ENDPOINTS;
  }

  public String[] adminEndpoints() {
    return ADMIN_ENDPOINTS;
  }

  public String[] employeeEndpoints() {
    return EMPLOYEE_ENDPOINTS;
  }

  public String[] publicEndpoints() {
    return PUBLIC_ENDPOINTS;
  }

  public boolean isAuthenticationRequired(String requestPath) {
    // check admin endpoints
    if (requestPath.startsWith("/api/v1/admin/")) {
      return true;
    }

    // check authenticated endpoints
    for (String pattern : authenticatedEndpoints()) {
      AntPathMatcher matcher = new AntPathMatcher();
      if (matcher.match(pattern, requestPath)) {
        return true;
      }
    }
    return false;
  }

}
