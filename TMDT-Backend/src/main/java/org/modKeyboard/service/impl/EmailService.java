package org.modKeyboard.service.impl;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modKeyboard.service.IEmailService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import java.util.concurrent.CompletableFuture;

import static org.modKeyboard.validate.Validator.isValidEmail;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmailService implements IEmailService {
  private final TemplateEngine templateEngine;
  private final JavaMailSender mailSender;
  @Value("${spring.mail.username}")
  private String username;

  @Override
  @Async
  public CompletableFuture<Void> sendForgotPasswordOTP(String email, String otp) {
    Context context = new Context();
    context.setVariable("otp", otp);
    context.setVariable("email", email);
    String process = templateEngine.process("forgot-password-otp.html", context);
    sendMail(email, "Mã OTP", process);
    return CompletableFuture.completedFuture(null);
  }

  @Override
  @Async
  public CompletableFuture<Void> sendForgotPassword(String email, String newPassword) {
    Context context = new Context();
    context.setVariable("newPassword", newPassword);
    context.setVariable("email", email);
    String process = templateEngine.process("forgot-password.html", context);
    sendMail(email, "Thiết lập lại mật khẩu", process);
    return CompletableFuture.completedFuture(null);
  }

//  private void sendMail(String to, String subject, String content) {
//    try {
//      MimeMessage message = mailSender.createMimeMessage();
//      MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
//      helper.setFrom(new InternetAddress(username));
//      helper.setTo(new InternetAddress(to));
//      helper.setSubject(subject);
//      helper.setText(content, true);
//
//      mailSender.send(message);
//    } catch (MessagingException ex) {
//      log.error(ex.getMessage());
//    }
//  }
private void sendMail(String to, String subject, String content) {
  try {
    if (!isValidEmail(to)) {
      log.error("Email không hợp lệ: {}", to);
      return;
    }

    MimeMessage message = mailSender.createMimeMessage();
    MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

    // ✅ Thêm tên hiển thị người gửi
    helper.setFrom(new InternetAddress(username, "ModKeyboard Team"));

    helper.setTo(new InternetAddress(to));
    helper.setSubject(subject);
    helper.setText(content, true);

    mailSender.send(message);
  } catch (Exception ex) {
    log.error("Gửi email thất bại đến {}: {}", to, ex.getMessage());

  }
}

//private void sendMail(String to, String subject, String content) {
//  try {
//    if (!isValidEmail(to)) {
//      log.error("Email không hợp lệ: {}", to);
//      return;
//    }
//
//    MimeMessage message = mailSender.createMimeMessage();
//    MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
//
//    helper.setFrom(username);
//    helper.setTo(to);
//    helper.setSubject(subject);
//    helper.setText(content, true);
//
//    mailSender.send(message);
//  } catch (MessagingException ex) {
//    log.error("Gửi email thất bại: {}", ex.getMessage());
//  }
//}

  @Override
  @Async
  public CompletableFuture<Void> sendEmailVerificationOTP(String email, String otp) {
    Context context = new Context();
    context.setVariable("otp", otp);
    context.setVariable("email", email);
    String process = templateEngine.process("email-verification-otp.html", context);
    sendMail(email, "Xác nhận email đăng ký", process);
    return CompletableFuture.completedFuture(null);
  }
}
