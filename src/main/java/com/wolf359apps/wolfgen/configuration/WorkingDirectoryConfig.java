package com.wolf359apps.wolfgen.configuration;

import com.wolf359apps.wolfgen.model.WorkingDirectory;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.nio.file.Path;
import java.nio.file.Paths;

@RequiredArgsConstructor
@Configuration
public class WorkingDirectoryConfig {

// 	private final ApplicationArguments applicationArguments;

	@Bean
	public WorkingDirectory workingDirectory() {

//		final Path workingDirectoryPath = Optional
//				.ofNullable(applicationArguments)
//				.map(ApplicationArguments::getSourceArgs)
//				.filter(arguments -> arguments.length == 1)
//				.map(arguments -> arguments[0])
//				.map(Path::of)
//				.orElse(Paths.get(Path.of(".").toUri()).getParent());
		return new WorkingDirectory(Paths.get(Path.of(".").toUri()).getParent());

	}

}
