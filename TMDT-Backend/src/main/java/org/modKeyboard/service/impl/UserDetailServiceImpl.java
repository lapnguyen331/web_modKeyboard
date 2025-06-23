package org.modKeyboard.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modKeyboard.dto.CustomUserSecurity;
import org.modKeyboard.entity.User;
import org.modKeyboard.exception.UserNotFoundException;
import org.modKeyboard.repository.UserRepository;
import org.springframework.data.domain.Example;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@FieldDefaults(makeFinal = true, level = lombok.AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class UserDetailServiceImpl implements UserDetailsService {
    UserRepository userRepo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Example<User> example = Example.of(User.builder().email(username).status(true).build());
        User user = userRepo.findOne(example).orElse(null);
        if (user == null) {
            throw new UserNotFoundException("User not found with email: " + username);
        }

        List<GrantedAuthority> authorities = user.getUserRoles().stream()
                .map(userRole -> new SimpleGrantedAuthority(userRole.getRole().getName().toString()))
                .collect(Collectors.toUnmodifiableList());

        return new CustomUserSecurity(user, authorities);
    }

}
