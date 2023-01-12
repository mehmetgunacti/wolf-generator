package com.wolf359apps.wolfgen.configuration;

import com.wolf359apps.wolfgen.model.WorkingDirectory;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.ApplicationArguments;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.nio.file.Path;
import java.util.Optional;

@RequiredArgsConstructor
@Configuration
public class WorkingDirectoryConfig {

	private final ApplicationArguments applicationArguments;

	@Bean
	public WorkingDirectory workingDirectory() {

		final Path workingDirectoryPath = Optional
				.ofNullable(applicationArguments)
				.map(ApplicationArguments::getSourceArgs)
				.filter(arguments -> arguments.length == 1)
				.map(arguments -> arguments[0])
				.map(Path::of)
				.orElse(Path.of(".").getParent());
		return new WorkingDirectory(workingDirectoryPath);

	}

}
