package com.wolf359apps.wolfgen.model;

import lombok.Getter;
import lombok.Setter;

import java.io.File;
import java.nio.file.Path;
import java.util.Optional;

@Getter
public class WorkingDirectory {

	private final Path     path;
	private       App.Info appInfo;
	private       Path     projectFolder;

	public WorkingDirectory(Path path) {
		this.path = path;
	}

	public void setAppInfo(App.Info info) {

		this.appInfo = info;
		this.projectFolder = path.resolve(appInfo.getArtifactId().toString());

	}

	public Path getFrontendDirectory() {

		return projectFolder.resolve("frontend");

	}

	public Path getBackendDirectory() {

		return projectFolder.resolve("backend");

	}

	public Path getDockerDirectory() {

		return projectFolder.resolve("docker");

	}

	public Path getDatabaseDirectory() {

		return projectFolder.resolve("database");

	}

	public Path getBackendSpringBootDirectory() {

		return getBackendDirectory().resolve("springboot");

	}

	public Path getFrontendAngularDirectory() {

		return getFrontendDirectory().resolve("angular");

	}

	public Path getDatabaseMySQLDirectory() {

		return getDatabaseDirectory().resolve("mysql");

	}

}
