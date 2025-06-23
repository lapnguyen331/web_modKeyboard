package org.modKeyboard.config;

import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modKeyboard.exception.JwtAuthenticationEntryPoint;
import org.modKeyboard.filter.JwtRequestFilter;
import org.modKeyboard.service.impl.UserDetailServiceImpl;
import org.modKeyboard.util.EndPoint;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@Configuration
@EnableWebSecurity
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class SecurityConfig {
  @Value("${application.frontend.url}")
  String frontendUrl;
  final UserDetailServiceImpl userDetails;
  final JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;
  final JwtRequestFilter jwtRequestFilter;

  /**
   * Defines the role hierarchy for Spring Security.
   * ADMIN > EMPLOYEE > CUSTOMER
   * This means:
   * - ADMIN users automatically have EMPLOYEE and CUSTOMER privileges.
   * - EMPLOYEE users automatically have CUSTOMER privileges.
   * This hierarchy allows for simplified role checks across the system.
   */
  @Bean
  public RoleHierarchy roleHierarchy() {
    return RoleHierarchyImpl
        .withDefaultRolePrefix()
        .role("ADMIN").implies("EMPLOYEE")
        .role("EMPLOYEE").implies("CUSTOMER")
        .build();
  }

  @Bean
  public SecurityFilterChain filterChain(
      HttpSecurity httpSecurity) throws Exception {

    // httpSecurity.authorizeHttpRequests(registry -> {
    // // All other requests are permitted for all users.
    // registry.requestMatchers("/**").permitAll();
    // });

    httpSecurity.authorizeHttpRequests(authorize -> {
      // Admin APIs
      authorize.requestMatchers(EndPoint.adminEndpoints()).hasRole("ADMIN");

      // Employee APIs
      authorize.requestMatchers(EndPoint.employeeEndpoints()).hasRole("EMPLOYEE");

      // Customer APIs
      authorize.requestMatchers(EndPoint.authenticatedEndpoints()).hasRole("CUSTOMER");

      // Public APIs – no authentication required
      authorize.requestMatchers(EndPoint.publicEndpoints())
          .permitAll();

      authorize.anyRequest().denyAll();
    });

    httpSecurity.exceptionHandling(exp -> exp.authenticationEntryPoint(jwtAuthenticationEntryPoint));
    httpSecurity.addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class);
    httpSecurity.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
    httpSecurity.httpBasic(Customizer.withDefaults());
    httpSecurity.csrf(AbstractHttpConfigurer::disable);
    httpSecurity.cors(Customizer.withDefaults());

    return httpSecurity.build();
  }

  @Bean
  public AuthenticationProvider authenticationProvider() {
    DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();

    authProvider.setUserDetailsService(userDetails);
    authProvider.setPasswordEncoder(passwordEncoder());

    return authProvider;
  }

  @Bean
  CorsConfigurationSource corsConfigurationSource() {
    CorsConfiguration configuration = new CorsConfiguration();
    configuration.setAllowCredentials(true);
    configuration.setAllowedOrigins(List.of(frontendUrl));
    configuration.setAllowedHeaders(List.of("*"));
    configuration.setAllowedMethods(List.of("*"));
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration("/**", configuration);
    return source;
  }

  @Bean
  public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
    return configuration.getAuthenticationManager();
  }

  @Bean
  PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder(10);
  }
}
