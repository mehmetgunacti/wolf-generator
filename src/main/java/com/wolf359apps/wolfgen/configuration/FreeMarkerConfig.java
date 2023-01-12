package com.wolf359apps.wolfgen.configuration;

import freemarker.template.TemplateExceptionHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@RequiredArgsConstructor
@Configuration
public class FreeMarkerConfig {

	@Bean
	public freemarker.template.Configuration freemarkerConfiguration() {

		freemarker.template.Configuration configuration = new freemarker.template.Configuration(freemarker.template.Configuration.VERSION_2_3_31);
		configuration.setDefaultEncoding("UTF-8");
		configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
		configuration.setLogTemplateExceptions(false);
		configuration.setWrapUncheckedExceptions(true);
		configuration.setFallbackOnNullLoopVariable(false);
		return configuration;

	}

}


//@Configuration
//public class FreeMarkerConfig {
//
//	private final FileSystemService fileSystemService;
//
//	@Bean
//	public freemarker.template.Configuration freemarkerConfiguration() {
//
//		final StringTemplateLoader stringLoader = new StringTemplateLoader();
//		Stream.of(ResourceFolder.values())
//				.map(fileSystemService::listTemplates)
//				.flatMap(Collection::stream)
//				.toList()
//				.forEach(
//						template -> stringLoader.putTemplate(
//								template.getRelativePath().toString(),
//								template.getContent()
//						)
//				);
//		freemarker.template.Configuration configuration = new freemarker.template.Configuration(freemarker.template.Configuration.VERSION_2_3_31);
//		configuration.setTemplateLoader(stringLoader);
//		return configuration;
//
//	}
//
//}


//// It's possible to add more than one template (they might include each other)
//// String secondTemplate = "<#include \"greetTemplate\"><@greet/> World!";
//// stringLoader.putTemplate("greetTemplate", secondTemplate);
// freemarker.template.Configuration configuration = new freemarker.template.Configuration();

// Template template = configuration.getTemplate(firstTemplate);

// FreeMarkerTemplateUtils.processTemplateIntoString()

// freemarker.template.Configuration configuration = new freemarker.template.Configuration(freemarker.template.Configuration.VERSION_2_3_29);
//        configuration.setClassForTemplateLoading(FreeMarkerConfig.class, "/templates");
//        configuration.setDefaultEncoding("UTF-8");
//        configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
//        configuration.setLogTemplateExceptions(false);
//        configuration.setWrapUncheckedExceptions(true);
//        configuration.setFallbackOnNullLoopVariable(false);
