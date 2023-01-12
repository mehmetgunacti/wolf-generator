package com.wolf359apps.wolfgen.constants;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.nio.file.Path;

@RequiredArgsConstructor
@Getter
public enum ResourceFolder {

	// Spring Boot
	backend_springboot_app(Path.of("backend", "springboot", "app")),
	backend_springboot_entities(Path.of("backend", "springboot", "entities")),
	backend_springboot_static_content(Path.of("backend", "springboot", "static-content")),
	backend_springboot_docker(Path.of("backend", "springboot", "docker")),

	// Angular
	frontend_angular_app(Path.of("frontend", "angular", "app")),
	frontend_angular_entities(Path.of("frontend", "angular", "entities")),
	frontend_angular_static_content(Path.of("frontend", "angular", "static-content")),
	frontend_angular_docker(Path.of("frontend", "angular", "docker")),

	// MySQL
	database_mysql_app(Path.of("database", "mysql", "app")),
	database_mysql_docker(Path.of("database", "mysql", "docker")),

	// Docker
	container_docker(Path.of("container", "docker", "app"));

	private final Path path;

}
