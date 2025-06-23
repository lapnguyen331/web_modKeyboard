package org.modKeyboard.config;

import io.github.cdimascio.dotenv.Dotenv;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MapPropertySource;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class EnvConfig implements ApplicationListener<ContextRefreshedEvent> {

  private final ConfigurableEnvironment environment;

  public EnvConfig(ConfigurableEnvironment environment) {
    this.environment = environment;
    loadDotenv();
  }

  private void loadDotenv() {
    // Load .env file from the root directory, ignoring if missing
    Dotenv dotenv = Dotenv.configure()
        .directory("./")
        .filename(".env")
        .ignoreIfMissing()
        .load();

    // Define mapping of environment variables to application properties
    Map<String, String> envMappings = getEnvMappings();

    // Load environment variables into a map, throwing exception for required but
    // missing values
    Map<String, Object> envMap = new HashMap<>();
    envMappings.forEach((envKey, propKey) -> {
      String value = dotenv.get(envKey);
      envMap.put(propKey, StringUtils.defaultIfBlank(value, ""));
    });

    // Add the dotenv properties to the Spring environment
    environment.getPropertySources().addFirst(new MapPropertySource("dotenvProperties", envMap));
  }

  /*
   * key is the environment variable name, value is the application property name
   */
  private Map<String, String> getEnvMappings() {
    Map<String, String> envMappings = new HashMap<>();
    envMappings.put("GOOGLE_CLIENT_ID", "spring.security.oauth2.client.registration.google.client-id");
    envMappings.put("GOOGLE_CLIENT_SECRET", "spring.security.oauth2.client.registration.google.client-secret");
    envMappings.put("MAIL_USERNAME", "spring.mail.username");
    envMappings.put("MAIL_PASSWORD", "spring.mail.password");
    envMappings.put("VNP_TMN_CODE", "VNP_TMN_CODE");
    envMappings.put("VNP_SECRET_KEY", "VNP_SECRET_KEY");
    envMappings.put("MOMO_SECRET_KEY", "MOMO_SECRET_KEY");
    envMappings.put("MOMO_ACCESS_KEY", "MOMO_ACCESS_KEY");
    envMappings.put("MOMO_PARTNER_CODE", "MOMO_PARTNER_CODE");
    envMappings.put("CLOUDINARY_CLOUD_NAME", "cloudinary.cloud_name");
    envMappings.put("CLOUDINARY_API_KEY", "cloudinary.api_key");
    envMappings.put("CLOUDINARY_API_SECRET", "cloudinary.api_secret");
    return envMappings;
  }

  @Override

  public void onApplicationEvent(ContextRefreshedEvent event) {
  }
}
