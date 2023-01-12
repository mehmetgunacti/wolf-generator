package ${ info.groupId }.configuration;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Getter
@Setter
@Configuration
// @PropertySource("classpath:bizim-ofis.properties")
@ConfigurationProperties(prefix = "bizimofis")
public class AppConfiguration {

	private String   environmentType;
	private String   adminEmail;
	private String[] corsAllowedOrigins;
	private String   jwtSecret;
	private Long     jwtExpirationInMs;
	private Long     jwtExpirationInMsForDownload;
	private String   pathToDokumanlar;
	private String   pathToVesikaliklar;
	private Integer  defaultPasswordExpiration;
	private Integer  defaultAccountExpiration;
	private String   emailSeparator;

}
