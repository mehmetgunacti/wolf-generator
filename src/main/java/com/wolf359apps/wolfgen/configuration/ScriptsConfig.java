package com.wolf359apps.wolfgen.configuration;

import com.wolf359apps.wolfgen.constants.TemplateKey;
import com.wolf359apps.wolfgen.exception.InvalidConfigurationException;
import com.wolf359apps.wolfgen.model.App;
import com.wolf359apps.wolfgen.model.Scripts;
import com.wolf359apps.wolfgen.model.Version;
import com.wolf359apps.wolfgen.util.processor.TemplateProcessor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Map;

@RequiredArgsConstructor
@Configuration
public class ScriptsConfig {

	private final TemplateProcessor templateProcessor;
	private final App.Info          appInfo;

	@Bean
	public Scripts scripts() {

		final Version version = version();
		try (InputStream is = new ClassPathResource("scripts.yaml.ftl").getInputStream()) {

			final String content = new String(is.readAllBytes(), StandardCharsets.UTF_8);
			final String output = templateProcessor.process(
					content,
					Map.of(
							TemplateKey.version, version(),
							TemplateKey.info, appInfo
					)
			);
			return new Yaml(new Constructor(Scripts.class)).load(output);

		} catch (IOException e) {
			throw new InvalidConfigurationException("YAML file : scripts.yaml.ftl", e);
		}

	}

	@Bean
	public Version version() {

		try (
				InputStream inputstream = new ClassPathResource("versions.yaml").getInputStream()
		) {

			return new Yaml(new Constructor(Version.class)).load(inputstream);

		} catch (IOException e) {
			throw new InvalidConfigurationException("YAML file : versions.yaml", e);
		}

	}

}
