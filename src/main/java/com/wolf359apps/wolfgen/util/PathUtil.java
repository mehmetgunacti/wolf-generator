package com.wolf359apps.wolfgen.util;

import com.wolf359apps.wolfgen.constants.PathKey;

import java.nio.file.Path;
import java.util.Map;

public class PathUtil {

	public static Path replace(Path path, Map<PathKey, String> replacements) {

		String pathString = path.toString();
		for (PathKey pathKey : replacements.keySet())
			pathString = pathString.replace(pathKey.name(), replacements.get(pathKey));
		return Path.of(pathString);

	}

}
