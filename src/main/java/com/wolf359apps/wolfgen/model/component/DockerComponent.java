package com.wolf359apps.wolfgen.model.component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DockerComponent {

	private boolean run;
	private boolean cleanup;
	private boolean startup;

	@Override
	public String toString() {
		return """
				Docker:
						run     : %s
						cleanup : %s
						startup : %s""".formatted(run, cleanup, startup);
	}

}
