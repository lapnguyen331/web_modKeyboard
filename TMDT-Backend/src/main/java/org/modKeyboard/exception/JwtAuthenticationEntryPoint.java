package org.modKeyboard.exception;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.modKeyboard.dto.response.ErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;
import java.io.IOException;

@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException)
            throws IOException {
        ErrorResponse error = ErrorResponse.builder()
                .error(HttpStatus.UNAUTHORIZED.getReasonPhrase())
                .message(authException.getMessage())
                .build();

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonError = objectMapper.writeValueAsString(error);

        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("status", HttpStatus.UNAUTHORIZED.value());
        jsonObject.addProperty("data", jsonError);
        response.setStatus(HttpStatus.UNAUTHORIZED.value());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.getWriter().write(jsonObject.toString());
    }
}

