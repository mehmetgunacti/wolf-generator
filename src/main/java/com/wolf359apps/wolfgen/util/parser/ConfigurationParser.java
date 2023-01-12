package com.wolf359apps.wolfgen.util.parser;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ConfigurationParser {

	// LinkedHashMap<String, String> parse(Path path);

	// <T> T parse(Path path, Class<?> clazz);

	// <T> T parse(String content);

	Map<String, Object> parseAsMap(String content);

	List<Map<String, Object>> parseAsList(String content);

	// Map<String, String> parseAsMap(String content);

	// <T> T parse(String content, Class<?> clazz);

	// String write(Object object);

}