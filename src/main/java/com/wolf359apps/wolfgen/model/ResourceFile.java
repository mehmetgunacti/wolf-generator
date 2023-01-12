package com.wolf359apps.wolfgen.model;

import com.wolf359apps.wolfgen.exception.FileSystemException;
import lombok.Getter;
import lombok.Setter;

import java.nio.file.Path;
import java.util.Optional;

@Setter
@Getter
public abstract class ResourceFile<T> {

	protected final Path relativePath;
	protected final T    content;
	protected       Path outputPath;

	public ResourceFile(Path relativePath, T content) {

		this.relativePath = relativePath;
		this.content = content;
		if (relativePath.isAbsolute())
			throw new FileSystemException("Parameter 'relativePath' [" + relativePath + "] is absolute.");

	}

	public Path getOutputPath() {

		return Optional
				.ofNullable(outputPath)
				.orElseThrow(() -> new NullPointerException("'outputPath' has to be set first."));

	}

	@Override
	public String toString() {
		return relativePath.toString();
	}

}
