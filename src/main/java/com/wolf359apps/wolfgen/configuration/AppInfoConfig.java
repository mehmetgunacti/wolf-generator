package com.wolf359apps.wolfgen.configuration;

import com.wolf359apps.wolfgen.exception.FileSystemException;
import com.wolf359apps.wolfgen.model.App;
import com.wolf359apps.wolfgen.model.WorkingDirectory;
import com.wolf359apps.wolfgen.model.name.KebabCase;
import com.wolf359apps.wolfgen.util.FileUtil;
import com.wolf359apps.wolfgen.util.parser.ConfigurationParser;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.nio.file.Files;
import java.util.Map;
import java.util.Optional;

@RequiredArgsConstructor
@Configuration
public class AppInfoConfig {

	private final ConfigurationParser configurationParser;
	private final WorkingDirectory    workingDirectory;

	@Bean
	public App.Info appInfo() {

		return Optional.of(
						workingDirectory.getPath().resolve("app-info.yaml")
				)
				.filter(Files::exists)
				.stream()
				.map(FileUtil::readFileContent)
				.map(configurationParser::parseAsMap)
				.map(this::map)
				.peek(workingDirectory::setAppInfo)
				.findFirst()
				.orElseThrow(() -> new FileSystemException("'app-info.yaml' file does not exist!"));

	}

	private App.Info map(Map<String, Object> map) {

		final App.Info info = new App.Info();
		info.setArtifactId(
				new KebabCase((String) map.get("artifactId"))
		);
		info.setTitle(
				(String) map.get("title")
		);
		info.setDescription(
				(String) map.get("description")
		);
		info.setGroupId(
				(String) map.get("groupId")
		);
		return info;

	}

}
