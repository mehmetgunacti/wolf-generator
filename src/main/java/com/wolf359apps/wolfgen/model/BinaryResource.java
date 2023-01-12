package com.wolf359apps.wolfgen.model;

import lombok.Getter;
import lombok.Setter;

import java.nio.file.Path;

@Getter
@Setter
public class BinaryResource extends ResourceFile<byte[]> {

	public BinaryResource(Path relativePath, byte[] content) {

		super(relativePath, content);

	}

}
