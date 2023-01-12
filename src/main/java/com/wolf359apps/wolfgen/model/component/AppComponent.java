package com.wolf359apps.wolfgen.model.component;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@RequiredArgsConstructor
abstract class AppComponent {

	protected final String name;

	protected boolean run;
	protected boolean gitInit;
	protected boolean dockerfile;

	@Override
	public String toString() {
		return """
				%s:
						run        : %s
						gitInit    : %s
						dockerfile : %s""".formatted(name, run, gitInit, dockerfile);
	}

}
