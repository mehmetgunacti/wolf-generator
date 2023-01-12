package com.wolf359apps.wolfgen.model.component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MySQLComponent extends AppComponent {

	private boolean randomData;
	private boolean phpMyAdmin;

	MySQLComponent() {
		super("MySQL");
	}

	@Override
	public String toString() {
		return """
				%s:
						run        : %s
						git        : %s
						docker     : %s
						randomData : %s
						phpMyAdmin : %s""".formatted(name, run, gitInit, dockerfile, randomData, phpMyAdmin);
	}

}
