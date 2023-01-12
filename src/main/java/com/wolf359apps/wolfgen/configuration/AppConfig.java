package com.wolf359apps.wolfgen.configuration;

import com.wolf359apps.wolfgen.exception.InvalidConfigurationException;
import com.wolf359apps.wolfgen.model.component.AppComponents;
import com.wolf359apps.wolfgen.util.parser.ConfigurationParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

import java.io.IOException;
import java.io.InputStream;

@Slf4j
@RequiredArgsConstructor
@Configuration
public class AppConfig {

	private final ApplicationArguments applicationArguments;
	private final ConfigurationParser  configurationParser;

	// @Bean
//    public App app() {
//
//        final String[] params = Optional
//                .of(applicationArguments)
//                .map(ApplicationArguments::getSourceArgs)
//                .filter(arguments -> arguments.length == 3)
//                .orElseThrow(() -> new InvalidConfigurationException("Arguments: 1) yaml 2) targetDir 3) tempDir"));
//
//        final String yamlFile  = params[0];
//        final String targetDir = params[1];
//        final String tempDir   = params[2];
//
//        final String yamlPath = Optional
//                .of(yamlFile)
//                .filter(yaml -> new File(yaml).exists())
//                .orElseThrow(() -> new InvalidConfigurationException("YAML file does not exist:" + yamlFile));

	// App app = (App) configurationParser.parse(Path.of(yamlPath), App.class);
	// app.setTargetDirectory(Path.of(targetDir));
	// app.setTempDirectory(Path.of(tempDir));
//        return app;
//
//    }

	@Bean
	public AppComponents appComponents() {

		try (InputStream inputstream = new ClassPathResource("app-components.yaml").getInputStream()) {

			AppComponents appComponents = new Yaml(new Constructor(AppComponents.class)).load(inputstream);
			log.info(appComponents.toString());
			return appComponents;

		} catch (IOException e) {
			throw new InvalidConfigurationException("YAML file : app-components.yaml", e);
		}

	}

}
