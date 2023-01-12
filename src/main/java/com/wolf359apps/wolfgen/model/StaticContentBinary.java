package com.wolf359apps.wolfgen.model;

import java.nio.file.Path;

public class StaticContentBinary extends BinaryResource {

	public StaticContentBinary(Path relativePath, byte[] content, App.Info info) {

		super(relativePath, content);

	}

}
