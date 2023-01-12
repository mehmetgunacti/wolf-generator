package com.wolf359apps.wolfgen.model.component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AppComponents {

	private FrontendComponents  frontend;
	private BackendComponents   backend;
	private DatabaseComponents  database;
	private ContainerComponents container;

	@Override
	public String toString() {
		return """
				Components:
				********************
				%s
				%s
				%s
				%s
				********************
				""".formatted(frontend, backend, database, container);
	}

}
