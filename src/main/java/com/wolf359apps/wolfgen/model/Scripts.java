package com.wolf359apps.wolfgen.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
public class Scripts {

	private CommandBundle dockerCleanup;
	private CommandBundle dockerStart;
	private CommandBundle spring;
	private CommandBundle angular;
	private CommandBundle buildAngular;
	private CommandBundle git;
	private CommandBundle maven;

	@Getter
	@Setter
	@ToString
	public static class CommandBundle {

		private boolean       fromCache = true;
		private List<Command> commands;

		@Getter
		@Setter
		@ToString
		public static class Command {

			private boolean  run       = true;
			private String[] command;
			private String   directory = "";

		}

	}
}