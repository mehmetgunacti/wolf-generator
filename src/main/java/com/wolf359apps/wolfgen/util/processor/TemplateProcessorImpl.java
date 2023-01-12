package com.wolf359apps.wolfgen.util.processor;

import com.wolf359apps.wolfgen.constants.TemplateKey;
import com.wolf359apps.wolfgen.exception.TemplateProcessingException;
import com.wolf359apps.wolfgen.model.App;
import com.wolf359apps.wolfgen.model.AppTemplate;
import com.wolf359apps.wolfgen.model.WorkingDirectory;
import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.StringReader;
import java.io.StringWriter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Service
public class TemplateProcessorImpl implements TemplateProcessor {

	//	private final WorkingDirectory workingDirectory;
	private final Configuration freemarkerConfiguration;
//	private final App.Info         appInfo;
//	private final List<App.Entity> appEntities;

//	@Override
//	public void process(AppTemplate appTemplate) {
//
//		appTemplate.setOutputContent(
//				process(
//						appTemplate,
//						Map.of(
//								TemplateKey.info.name(), appInfo,
//								TemplateKey.entities.name(), appEntities,
//								TemplateKey.workingDirectory.name(), workingDirectory
//						)
//				)
//		);
//
//	}

//	@Override
//	public void process(EntityTemplate entityTemplate) {
//
//		entityTemplate.setOutputContent(
//				process(
//						entityTemplate,
//						Map.of(
//								TemplateKey.info.name(), appInfo,
//								TemplateKey.entity.name(), entityTemplate.getEntity(),
//								TemplateKey.workingDirectory.name(), workingDirectory
//						)
//				)
//		);
//
//	}

	@Override
	public String process(String content, Map<TemplateKey, Object> map) {

		try {

			// get template
			final Template     freemarkerTemplate = new Template("templateName", new StringReader(content), freemarkerConfiguration);
			final StringWriter writer             = new StringWriter();

			// process input
			freemarkerTemplate.process(convert(map), writer);

			// return processed template
			return writer.toString();

		} catch (Exception e) {
			throw new TemplateProcessingException("Content could not be processed.", e);
		}

	}

	private Map<String, Object> convert(Map<TemplateKey, Object> map) {

		return map
				.entrySet()
				.stream()
				.collect(
						Collectors.toMap(
								e -> e.getKey().name(),
								Map.Entry::getValue
						)
				);

	}

//	private String process(AppTemplate appTemplate, Map<String, Object> map) {
//
//		try {
//
//			log.info("processing template : " + appTemplate.getRelativePath());
//
//			// get template
//			final Template     freemarkerTemplate = new Template("templateName", new StringReader(appTemplate.getContent()), freemarkerConfiguration);
//			final StringWriter writer             = new StringWriter();
//
//			// process input
//			freemarkerTemplate.process(map, writer);
//
//			// return processed template
//			return writer.toString();
//
//		} catch (Exception e) {
//			throw new TemplateProcessingException("TemplateFile : " + appTemplate, e);
//		}
//
//	}

}

//	private String extractRelativePath(String path) {
//
//		// if
//		// path is          : jar:file:/home/[...]/Projects/wolf-generator-app/wolf-generator/target/wolf-generator-1.0-SNAPSHOT.jar!/BOOT-INF/classes!/templates/app/backend/src/main/resources/mybatis-config.xml.ftl
//		// and
//		// classpathRoot is : jar:file:/home/[...]/Projects/wolf-generator-app/wolf-generator/target/wolf-generator-1.0-SNAPSHOT.jar!/BOOT-INF/classes!/
//		// result should be : app/backend/src/main/resources/mybatis-config.xml.ftl
//		String s = path.substring((classpathRoot + "templates" + File.separator).length());
//		return s;
//
//	}

//    public void process(String content, Object params, Path output) {
//
//        try {
//
//            // get template
//            Template     template = new Template("dynamic", content, freemarkerConfiguration);
//            StringWriter writer   = new StringWriter();
//
//            Map<String, Object> root = new HashMap<>();
//            root.put("content", content);
//            root.put("params", params);
//
//
//            // process input
//            template.process(params, writer);
//
//            // save file
//            fileSystemService.createFile(
//                    output.toString(),
//                    writer.toString()
//            );
//
//        } catch (Exception e) {
//            throw new TemplateProcessingException("TemplateFile : " + e.getMessage(), e);
//        }
//
//    }
//
//    @Override
//    public void process(SourceFileType sou staticContentFile) {
//
//        fileSystemService.copyToOutput(staticContentFile);
//
//    }