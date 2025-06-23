package org.modKeyboard.mapper;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modKeyboard.dto.GooglePojo;
import org.modKeyboard.dto.UserDTO;
import org.modKeyboard.entity.User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Component;

@Component
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class UserMapper {

    public UserDTO toDTO(User user) {
        if (user == null) {
            return null;
        }

        UserDTO userDTO = new UserDTO();
        userDTO.setId(user.getId());
        userDTO.setEmail(user.getEmail());
        userDTO.setPassword(user.getPassword());
        userDTO.setFullName(user.getFullName());
        userDTO.setPhone(user.getPhone());
        userDTO.setStatus(user.getStatus());
        userDTO.setRoles(user.getUserRoles()
                .stream()
                .map(userRole -> userRole.getRole().getName()).toList());

        return userDTO;
    }

    public GooglePojo toGooglePojo(OAuth2User user) {
        if (user == null) {
            return null;
        }

        GooglePojo googlePojo = new GooglePojo();

        googlePojo.setSub(user.getAttribute("sub"));
        googlePojo.setName(user.getAttribute("name"));
        googlePojo.setGivenName(user.getAttribute("given_name"));
        googlePojo.setFamilyName(user.getAttribute("family_name"));
        googlePojo.setEmail(user.getAttribute("email"));
        googlePojo.setPicture(user.getAttribute("picture"));
        googlePojo.setHd(user.getAttribute("hd"));
        Object emailVerified = user.getAttribute("email_verified");
        if (emailVerified != null) {
            googlePojo.setEmailVerified(Boolean.parseBoolean(emailVerified.toString()));
        }

        return googlePojo;
    }

    public User toEntity(GooglePojo googlePojo) {

        if (googlePojo == null) {
            return null;
        }

        User user = new User();

        user.setEmail(googlePojo.getEmail());
        user.setFullName(googlePojo.getName());

        return user;
    }
}
