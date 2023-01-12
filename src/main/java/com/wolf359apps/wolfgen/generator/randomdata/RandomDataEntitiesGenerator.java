package com.wolf359apps.wolfgen.generator.randomdata;

import com.github.javafaker.Faker;
import com.wolf359apps.wolfgen.model.App;
import com.wolf359apps.wolfgen.model.Generator;
import com.wolf359apps.wolfgen.util.filesystem.FileSystemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.jdbc.SQL;
import org.springframework.stereotype.Component;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Component
public class RandomDataEntitiesGenerator implements Generator {

	// private final FileSystemService fileSystemService;
	private final List<App.Entity> appEntities;
	private final Faker            faker;

	@Override
	public void generate() {

		StringBuilder sb = new StringBuilder();
		appEntities.add(getUser());
//        appEntities
//                .forEach(entity ->
//                        sb.append(
//                                generateInsert(
//                                        appDatabase.getSchema(),
//                                        entity.getName().getPlural().getSnake().toString(),
//                                        entity.getFields(),
//                                        10
//                                )
//                        ).append(";").append("\r\n")
//                );

		// fileSystemService.createFile(appInfo.getArtifactId() + "-resources/random.sql", sb.toString());

	}

	private String generateInsert(String schema, String tablename, List<App.Entity.Field> fields, int times) {

		SQL sql = new SQL()
				.INSERT_INTO("`" + schema + "`.`" + tablename + "`")
				.INTO_COLUMNS(
						fields
								.stream()
								.map(App.Entity.Field::getName)
								.map(name -> "`" + name + "`")
								.collect(Collectors.joining(", "))
				);

		do {

			sql.INTO_VALUES(
					fields
							.stream()
							.map(this::mapField)
							.map(Object::toString)
							.collect(Collectors.joining(", "))
			);

			if (--times > 0)
				sql.ADD_ROW();

		} while (times > 0);

		return sql.toString();


	}

	private String mapField(App.Entity.Field field) {

		if (field.getDefaultValue() != null)
			return field.getDefaultValue().toString();

		Object object = switch (field.getType()) {

			case number -> faker.random().nextInt(10, 10000);
			case text -> "'" + faker.starTrek().character().replace("'", "") + "'";
			case password -> "'$2a$10$BqHfNjtf8Ad9K6Zd0CrO4.YvTgBtYv7dlnsNh9zfS55cmdaldHgdy'";
			case email -> "'" + faker.internet().emailAddress() + "'";
			case phone -> "'" + faker.phoneNumber().phoneNumber() + "'";
			case date ->
					"'" + Instant.ofEpochMilli(faker.date().birthday().getTime()).atZone(ZoneId.systemDefault()).toLocalDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + "'";
			case timestamp -> "'" + Instant.now().toString().replaceAll("[TZ]", " ").trim() + "'";
			case money -> faker.random().nextDouble();
			case bool -> faker.random().nextBoolean().toString();

		};
		return object.toString();

	}

	private App.Entity getUser() {

		final String userYaml = """

				name:
				  singular: "user"
				  plural: "users"
				fields:
				  - { name: "name",                 type: "text",      required: true, max:  45 }
				  - { name: "username",             type: "text",      required: true, max:  30 }
				  - { name: "password",             type: "password",  required: true, max: 100 }
				  - { name: "birthdate",            type: "date",      required: true }
				  - { name: "title",                type: "text",      required: true, max: 45 }
				  - { name: "mobile",               type: "text",      required: true, max: 45 }
				  - { name: "phone",                type: "text",      required: true, max: 45 }
				  - { name: "last_login",           type: "timestamp", required: true }
				  - { name: "password_expiration",  type: "timestamp", required: true }
				  - { name: "account_expiration",   type: "timestamp", required: true }
				  - { name: "password_attempts",    type: "number",    required: true, defaultValue: 0 }

				""";
		return new Yaml(new Constructor(App.Entity.class)).load(userYaml);

	}

}
