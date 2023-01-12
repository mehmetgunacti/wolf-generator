package com.wolf359apps.wolfgen.model;

import lombok.Getter;
import lombok.Setter;

import java.nio.file.Path;

@Getter
@Setter
public class AppTemplate extends ResourceFile<String> {

	private String outputContent;

	public AppTemplate(Path relativePath, String content) {

		super(relativePath, content);

	}

}
