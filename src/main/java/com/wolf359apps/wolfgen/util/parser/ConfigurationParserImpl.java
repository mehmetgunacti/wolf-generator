package com.wolf359apps.wolfgen.util.parser;

import com.wolf359apps.wolfgen.exception.InvalidConfigurationException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;
import org.yaml.snakeyaml.nodes.Node;
import org.yaml.snakeyaml.nodes.SequenceNode;

import java.io.IOException;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
public class ConfigurationParserImpl implements ConfigurationParser {
//
//	@Override
//	public LinkedHashMap<String, String> parse(Path path) {
//
//		try {
//
//			return new Yaml()
//					.load(
//							FileUtils.readFileToString(
//									path.toFile(),
//									StandardCharsets.UTF_8
//							)
//					);
//
//		} catch (IOException e) {
//			throw new InvalidConfigurationException("YAML file : " + path, e);
//		}
//
//	}
//
//	@Override
//	public <T> T parse(Path path, Class<?> clazz) {
//
//		try {
//
//			return parse(
//					FileUtils.readFileToString(
//							path.toFile(),
//							StandardCharsets.UTF_8
//					),
//					clazz
//			);
//
//		} catch (IOException e) {
//			throw new InvalidConfigurationException("YAML file : " + path, e);
//		}
//
//	}

	@Override
	public Map<String, Object> parseAsMap(String content) {

		return new Yaml().load(content);

	}

	@Override
	public List<Map<String, Object>> parseAsList(String content) {

		return new Yaml().load(content);

	}

//
//	@Override
//	public String write(Object object) {
//
//		StringWriter writer = new StringWriter();
//		new Yaml().dump(object, writer);
//		return writer.toString();
//
//	}
//
//	@Override
//	public <T> T parseList(Path path, Class<?> clazz) {
//
//		try {
//
//			return new Yaml(new ListConstructor<>(clazz))
//					.load(
//							FileUtils.readFileToString(
//									path.toFile(),
//									StandardCharsets.UTF_8
//							)
//					);
//
//		} catch (IOException e) {
//			throw new InvalidConfigurationException("YAML file : " + path, e);
//		}
//
//	}
//
//	private static class ListConstructor<T> extends Constructor {
//
//		private final Class<T> clazz;
//
//		public ListConstructor(final Class<T> clazz) {
//
//			this.clazz = clazz;
//
//		}
//
//		@Override
//		protected Object constructObject(final Node node) {
//
//			if (node instanceof SequenceNode && isRootNode(node))
//				((SequenceNode) node).setListType(clazz);
//			return super.constructObject(node);
//
//		}
//
//		private boolean isRootNode(final Node node) {
//
//			return node.getStartMark().getIndex() == 0;
//
//		}
//
//	}

}
