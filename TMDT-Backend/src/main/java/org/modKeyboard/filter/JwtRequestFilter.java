package org.modKeyboard.filter;

import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.modKeyboard.dto.CustomUserSecurity;
import org.modKeyboard.exception.JwtAuthenticationEntryPoint;
import org.modKeyboard.service.IKeyService;
import org.modKeyboard.service.impl.JwtService;
import org.modKeyboard.service.impl.UserDetailServiceImpl;
import org.modKeyboard.util.EndPoint;
import org.modKeyboard.util.JwtHelper;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.modKeyboard.exception.ResourceNotFoundException;

import java.io.IOException;
import java.security.PublicKey;

/*
The JwtRequestFilter extends the Spring Web Filter OncePerRequestFilter class. For any incoming request this Filter
class gets executed. It checks if the request has a valid JWT token. If it has a valid JWT Token then it sets the
 Authentication in the context, to specify that the current user is authenticated.
 */

@Component
@FieldDefaults(makeFinal = true, level = lombok.AccessLevel.PRIVATE)
@RequiredArgsConstructor
@Slf4j
public class JwtRequestFilter extends OncePerRequestFilter {
    IKeyService keyService;
    UserDetailServiceImpl userDetailService;
    JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;
    JwtService jwtService;
    JwtHelper jwtHelper;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {

        String requestPath = request.getRequestURI();

        // check if the request path requires authentication
        boolean requiresAuthentication = EndPoint.isAuthenticationRequired(requestPath);
        if (!requiresAuthentication) {
            chain.doFilter(request, response); // continue the filter chain
            return;
        }

        final String requestTokenHeader = request.getHeader("Authorization");

        String email = null;
        String jwtToken = null;
        // JWT Token is in the form "Bearer token", Remove Bearer word and get only the Token
        if (requestTokenHeader != null && requestTokenHeader.startsWith("Bearer ")) {
            jwtToken = requestTokenHeader.substring("Bearer ".length());
            try {
                email = jwtHelper.extractEmailFromPayload(jwtToken);
            } catch (IllegalArgumentException e) {
                log.warn("Unable to get JWT Token");
                throw new IllegalArgumentException("Unable to get JWT Token");
            }
        } else {
            log.warn("JWT Token does not begin with Bearer String");
            throw new IllegalArgumentException("JWT Token does not begin with Bearer String");
        }

        // Once we get the token validate it.
        SecurityContext context = SecurityContextHolder.getContext();

        if (email != null && context.getAuthentication() == null) {

            CustomUserSecurity userDetails = (CustomUserSecurity) userDetailService.loadUserByUsername(email);
            PublicKey publicKey = keyService.getKeyPairByUser(userDetails.getId()).getPublic();
            // if token is valid configure Spring Security to manually set
            // authentication
            try {
                if (jwtService.validateToken(jwtToken, publicKey)) {
                    UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                            userDetails, null, userDetails.getAuthorities());
                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    // After setting the Authentication in the context, we specify
                    // that the current user is authenticated. So it passes the
                    // Spring Security Configurations successfully.
                    context.setAuthentication(authToken);
                }
            } catch (ExpiredJwtException e) {
                log.warn("JWT Token has expired during validation");
                AuthenticationException authException = new AuthenticationServiceException("JWT Token has expired", e);
                jwtAuthenticationEntryPoint.commence(request, response, authException);
                return;
            }
        }
        chain.doFilter(request, response);
    }

}
