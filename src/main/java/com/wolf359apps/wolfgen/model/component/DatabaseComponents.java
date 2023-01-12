package com.wolf359apps.wolfgen.model.component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DatabaseComponents {

	private MySQLComponent      mysql;
	public boolean isRun() {

		return mysql.isRun();

	}

	@Override
	public String toString() {
		return """
				Database:
					%s""".formatted(mysql);
	}

}
