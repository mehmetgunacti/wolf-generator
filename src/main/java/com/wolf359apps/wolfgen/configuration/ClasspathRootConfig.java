package com.wolf359apps.wolfgen.configuration;

import com.wolf359apps.wolfgen.exception.FileSystemException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import java.nio.file.Path;

@Slf4j
@Configuration
public class ClasspathRootConfig {

	@Bean
	public Path classpathRoot() {

		try {

			log.info("Classpath Root: " + Path.of(new ClassPathResource(".").getURI().toString()));
			return Path.of(new ClassPathResource(".").getURI().toString());

		} catch (Exception e) {
			throw new FileSystemException(e);
		}

	}

}
