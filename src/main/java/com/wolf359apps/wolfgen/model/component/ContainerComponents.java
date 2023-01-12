package com.wolf359apps.wolfgen.model.component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ContainerComponents {

	private DockerComponent     docker;
	private PhpMyAdminComponent phpMyAdmin;

	public boolean isRun() {

		return docker.isRun() || phpMyAdmin.isRun();

	}

	@Override
	public String toString() {
		return """
				Container:
					%s
					%s""".formatted(docker, phpMyAdmin);
	}

}
