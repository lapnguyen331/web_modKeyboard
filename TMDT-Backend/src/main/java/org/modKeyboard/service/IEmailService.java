package org.modKeyboard.service;

import java.util.concurrent.CompletableFuture;

public interface IEmailService {

  CompletableFuture<Void> sendForgotPasswordOTP(String email, String otp);

  CompletableFuture<Void> sendForgotPassword(String email, String newPassword);

  CompletableFuture<Void> sendEmailVerificationOTP(String email, String otp);
}
