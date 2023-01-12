package com.wolf359apps.wolfgen.generator.docker;

import com.wolf359apps.wolfgen.constants.ResourceFolder;
import com.wolf359apps.wolfgen.constants.TemplateKey;
import com.wolf359apps.wolfgen.model.App;
import com.wolf359apps.wolfgen.model.AppTemplate;
import com.wolf359apps.wolfgen.model.Generator;
import com.wolf359apps.wolfgen.model.Version;
import com.wolf359apps.wolfgen.model.WorkingDirectory;
import com.wolf359apps.wolfgen.model.component.AppComponents;
import com.wolf359apps.wolfgen.util.filesystem.FileSystemService;
import com.wolf359apps.wolfgen.util.processor.TemplateProcessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.Map;
import java.util.function.Consumer;

@Slf4j
@RequiredArgsConstructor
@Component
public class DockerComposeGenerator implements Generator {

	private final FileSystemService fileSystemService;
	private final App.Info          appInfo;
	private final Version           version;
	private final TemplateProcessor templateProcessor;
	private final WorkingDirectory  workingDirectory;
	private final AppComponents     appComponents;

	@Override
	public void generate() {

		fileSystemService.createDirectory(
				workingDirectory.getDockerDirectory()
		);
		processAppTemplates();

	}

	private void processAppTemplates() {

		final Consumer<AppTemplate> setOutputPath = resourceFile -> {

			final String relativePath = resourceFile.getRelativePath().toString();
			resourceFile.setOutputPath(
					workingDirectory
							.getDockerDirectory()
							.resolve(StringUtils.stripFilenameExtension(relativePath))
							.toAbsolutePath()
			);

		};

		final Map<TemplateKey, Object> map = Map.of(
				TemplateKey.info, appInfo,
				TemplateKey.version, version,
				TemplateKey.appComponents, appComponents
		);

		fileSystemService
				.listTemplates(ResourceFolder.container_docker)
				.stream()
				.peek(template -> log.info("Input: " + template.getRelativePath().toString()))
				.peek(setOutputPath)
				.peek(template -> log.info("Output: " + template.getOutputPath()))
				.peek(
						template -> template.setOutputContent(
								templateProcessor.process(template.getContent(), map)
						)
				)
				.forEach(fileSystemService::create);

	}

}
