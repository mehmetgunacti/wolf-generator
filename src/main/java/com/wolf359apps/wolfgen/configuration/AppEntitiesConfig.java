package com.wolf359apps.wolfgen.configuration;

import com.wolf359apps.wolfgen.constants.FieldType;
import com.wolf359apps.wolfgen.exception.FileSystemException;
import com.wolf359apps.wolfgen.model.App;
import com.wolf359apps.wolfgen.model.WorkingDirectory;
import com.wolf359apps.wolfgen.model.name.CamelCase;
import com.wolf359apps.wolfgen.util.FileUtil;
import com.wolf359apps.wolfgen.util.parser.ConfigurationParser;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.nio.file.Files;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Configuration
public class AppEntitiesConfig {

	private final ConfigurationParser configurationParser;
	private final WorkingDirectory    workingDirectory;

	@Bean
	public List<App.Entity> appEntities() {

		return Optional.of(
						workingDirectory.getPath().resolve("app-entities.yaml")
				)
				.filter(Files::exists)
				.map(FileUtil::readFileContent)
				.map(configurationParser::parseAsList)
				.map(this::createEntityList)
				.orElseThrow(() -> new FileSystemException("'app-entities.yaml' file does not exist!"));

	}

	private List<App.Entity> createEntityList(List<Map<String, Object>> list) {

		return list
				.stream()
				.map(this::createEntity)
				.collect(Collectors.toList());

	}

	@SuppressWarnings("unchecked")
	private App.Entity createEntity(Map<String, Object> map) {

		final App.Entity entity = new App.Entity();
		entity.setName(
				createEntityName(
						(Map<String, Object>) map.get("name")
				)
		);
		entity.setFields(
				createEntityFields(
						(List<Map<String, Object>>) map.get("fields")
				)
		);
		return entity;

	}

	private List<App.Entity.Field> createEntityFields(List<Map<String, Object>> list) {

		return list
				.stream()
				.map(this::createEntityField)
				.collect(Collectors.toList());

	}

	private App.Entity.Field createEntityField(Map<String, Object> map) {

		final App.Entity.Field field = new App.Entity.Field();
		field.setName(
				new CamelCase(
						(String) map.get("name")
				)
		);
		field.setType(
				FieldType.valueOf(
						(String) map.get("type")
				)
		);
		field.setJava(
				(String) map.get("java")
		);
		field.setTypescript(
				(String) map.get("typescript")
		);
		field.setMysql(
				(String) map.get("mysql")
		);
		field.setRequired(
				(Boolean) map.get("required")
		);
		field.setMax(
				(Integer) map.get("max")
		);
		field.setMin(
				(Integer) map.get("min")
		);
		field.setDefaultValue(
				map.get("defaultValue")
		);
		return field;

	}

	private App.Entity.EntityName createEntityName(Map<String, Object> map) {

		final App.Entity.EntityName name = new App.Entity.EntityName();
		name.setSingular(
				(String) map.get("singular")
		);
		name.setPlural(
				(String) map.get("plural")
		);
		return name;

	}

}
