package com.wolf359apps.wolfgen.model.component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FrontendComponents {

	private AngularComponent angular;

	public boolean isRun() {

		return angular.isRun();

	}

	@Override
	public String toString() {
		return """
				Frontend:
					%s""".formatted(angular);
	}

}
