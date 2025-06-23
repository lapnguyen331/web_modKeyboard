package org.modKeyboard.service.impl;

import java.sql.Timestamp;
import java.util.Random;
import java.util.UUID;

import org.modKeyboard.dto.GooglePojo;
import org.modKeyboard.dto.UserDTO;
import org.modKeyboard.dto.enums.RoleEnum;
import org.modKeyboard.dto.request.RegistrationRequest;
import org.modKeyboard.entity.Role;
import org.modKeyboard.entity.User;
import org.modKeyboard.entity.UserOtp;
import org.modKeyboard.entity.UserRole;
import org.modKeyboard.exception.ResourceNotFoundException;
import org.modKeyboard.exception.UserNotFoundException;
import org.modKeyboard.mapper.UserMapper;
import org.modKeyboard.repository.OtpRepository;
import org.modKeyboard.repository.RoleRepository;
import org.modKeyboard.repository.UserRepository;
import org.modKeyboard.service.IEmailService;
import org.modKeyboard.service.IKeyService;
import org.modKeyboard.service.IUserService;
import org.springframework.data.domain.Example;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.uuid.Generators;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserService implements IUserService {
  UserMapper userMapper;
  UserRepository userRepository;
  PasswordEncoder passwordEncoder;
  RoleRepository roleRepository;
  OtpRepository otpRepository;
  IKeyService keyService;
  IEmailService emailService;

  @Override
  public UserDTO getUserById(UUID id) throws UserNotFoundException {
    User user = userRepository.findByIdAndStatus(id, true)
        .orElseThrow(() -> new UserNotFoundException("User not found"));
    return userMapper.toDTO(user);
  }

  @Override
  public UserDTO getByEmail(String email) throws UserNotFoundException {
    User user = userRepository.findByEmail(email)
        .orElseThrow(() -> new UserNotFoundException("User not found"));

    return userMapper.toDTO(user);
  }

  @Override
  @Transactional
  public UserDTO createUser(GooglePojo googlePojo) {

    if (userRepository.existsByEmail(googlePojo.getEmail())) {
      throw new IllegalArgumentException("User with email already exists");
    }

    User user = userMapper.toEntity(googlePojo);
    user.setPassword(passwordEncoder.encode(Generators.randomBasedGenerator().toString()));
    user.setStatus(true);
    // Save the User entity to the database
    user = userRepository.save(user);

    UserRole userRole = UserRole.builder()
        .user(user)
        .role(roleRepository.findByName(RoleEnum.ROLE_CUSTOMER))
        .build();
    // persist user role associated for user
    user.addUserRole(userRole);
    user = userRepository.save(user);

    // Return true if the user was created successfully, false otherwise
    return userMapper.toDTO(user);
  }

  @Override
  public boolean isEmailExists(String email) {
    return userRepository.existsByEmail(email);
  }

  @Override
  public String generateForgotPasswordOTP(String email) {
    Example<User> example = Example.of(User.builder().email(email).status(true).build());
    User user = userRepository.findOne(example).orElseThrow(UserNotFoundException::new);

    // Generate a random OTP with 5 numbers
    String otp = String.valueOf(10000 + new Random().nextInt(90000));
    // Save the OTP to the database
    otpRepository.save(UserOtp.builder()
        .otpCode(otp)
        .user(user)
        .type(UserOtp.OtpType.FORGOT_PASSWORD)
        .expiredAt(new Timestamp(System.currentTimeMillis() + 10 * 60 * 1000)) // Set expiration time to 10 minutes
        .build());

    // Return the generated OTP
    return otp;
  }

  @Override
  @Transactional
  public UserDTO forgotPassword(String otp) {

    UserOtp userOtp = otpRepository.findByOtpCode(otp)
        .orElseThrow(() -> new ResourceNotFoundException("Invalid OTP"));

    if (userOtp.getExpiredAt().before(new Timestamp(System.currentTimeMillis()))) {
      throw new IllegalArgumentException("OTP expired");
    }

    String newPassword = UUID.randomUUID().toString().substring(0, 8);

    User user = userOtp.getUser();
    user.setPassword(passwordEncoder.encode(newPassword));
    userRepository.save(user);

    // Delete the OTP after use
    otpRepository.delete(userOtp);

    // reset the key pair for the user
    keyService.resetKeyPair(user.getId());

    return UserDTO.builder().email(user.getEmail()).password(newPassword).build();
  }

  @Override
  @Transactional
  public UserDTO registerUser(RegistrationRequest request) {
    // Check if email already exists
    if (userRepository.existsByEmail(request.getEmail())) {
      throw new IllegalArgumentException("Email đã tồn tại trong hệ thống");
    }

    Role customerRole = roleRepository.findByName(RoleEnum.ROLE_CUSTOMER);
    // Kiểm tra và xử lý nếu role không tồn tại
    if (customerRole == null) {
      // Log lỗi
      log.error("Customer role not found with name: " + RoleEnum.ROLE_CUSTOMER);
      throw new RuntimeException("Customer role not found in the system");
    }

    // Sau đó mới tạo user
    User user = User.builder()
        .email(request.getEmail())
        .password(passwordEncoder.encode(request.getPassword()))
        .fullName(request.getFullName())
        .phone(request.getPhone())
        .status(false)
        .build();

    // Save user to database
    user = userRepository.save(user);

    UserRole userRole = UserRole.builder()
        .user(user)
        .role(customerRole)
        .build();
    // persist user role associated for user
    user.addUserRole(userRole);
    user = userRepository.save(user);
    // Generate verification OTP
    String otp = String.valueOf(10000 + new Random().nextInt(90000));

    // Save OTP to database
    otpRepository.save(UserOtp.builder()
        .otpCode(otp)
        .user(user)
        .type(UserOtp.OtpType.VERIFY_EMAIL)
        .expiredAt(new Timestamp(System.currentTimeMillis() + 30 * 60 * 1000)) // 30 minutes expiration
        .build());

    // Send verification email asynchronously
    emailService.sendEmailVerificationOTP(request.getEmail(), otp);
    // Return user DTO
    return userMapper.toDTO(user);
  }

  // Add this new method for email verification
  @Override
  @Transactional
  public UserDTO verifyEmail(String otp) {
    UserOtp userOtp = otpRepository.findByOtpCodeAndType(otp, UserOtp.OtpType.VERIFY_EMAIL)
        .orElseThrow(() -> new ResourceNotFoundException("Mã OTP không hợp lệ"));

    if (userOtp.getExpiredAt().before(new Timestamp(System.currentTimeMillis()))) {
      throw new IllegalArgumentException("Mã OTP đã hết hạn");
    }

    User user = userOtp.getUser();
    user.setStatus(true); // Activate user account
    userRepository.save(user);

    // Delete the OTP after use
    otpRepository.delete(userOtp);

    return userMapper.toDTO(user);
  }
}
