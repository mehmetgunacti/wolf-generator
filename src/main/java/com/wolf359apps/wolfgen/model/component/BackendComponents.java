package com.wolf359apps.wolfgen.model.component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BackendComponents {

	private SpringBootComponent springBoot;

	public boolean isRun() {

		return springBoot.isRun();

	}

	@Override
	public String toString() {
		return """
				Backend:
					%s""".formatted(springBoot);
	}

}
