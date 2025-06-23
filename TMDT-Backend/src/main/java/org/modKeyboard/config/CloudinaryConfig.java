package org.modKeyboard.config;

import com.cloudinary.Cloudinary;

import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;

import org.modKeyboard.config.properties.CloudinaryProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
@FieldDefaults(level = AccessLevel.PRIVATE)
@EnableConfigurationProperties(CloudinaryProperties.class)
public class CloudinaryConfig {

  @Bean
  Cloudinary getCloudinary(CloudinaryProperties props) {
    Map<String, Object> config = new HashMap<>();
    config.put("cloud_name", props.cloudName());
    config.put("api_key", props.apiKey());
    config.put("api_secret", props.apiSecret());
    config.put("secure", props.secure());
    return new Cloudinary(config);
  }
}
