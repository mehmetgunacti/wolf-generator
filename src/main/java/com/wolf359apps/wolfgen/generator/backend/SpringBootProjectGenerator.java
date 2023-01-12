package com.wolf359apps.wolfgen.generator.backend;

import com.wolf359apps.wolfgen.constants.PathKey;
import com.wolf359apps.wolfgen.constants.ResourceFolder;
import com.wolf359apps.wolfgen.constants.TemplateKey;
import com.wolf359apps.wolfgen.model.App;
import com.wolf359apps.wolfgen.model.AppTemplate;
import com.wolf359apps.wolfgen.model.BinaryResource;
import com.wolf359apps.wolfgen.model.DockerGenerator;
import com.wolf359apps.wolfgen.model.Generator;
import com.wolf359apps.wolfgen.model.GitGenerator;
import com.wolf359apps.wolfgen.model.Scripts;
import com.wolf359apps.wolfgen.model.Version;
import com.wolf359apps.wolfgen.model.WorkingDirectory;
import com.wolf359apps.wolfgen.model.component.AppComponents;
import com.wolf359apps.wolfgen.util.FileUtil;
import com.wolf359apps.wolfgen.util.filesystem.FileSystemService;
import com.wolf359apps.wolfgen.util.processor.TemplateProcessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.ClassUtils;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.function.BiConsumer;
import java.util.function.Consumer;

@Slf4j
@RequiredArgsConstructor
@Component
public class SpringBootProjectGenerator implements Generator, GitGenerator, DockerGenerator {

	private final AppComponents     appComponents;
	private final FileSystemService fileSystemService;
	private final TemplateProcessor templateProcessor;
	private final List<App.Entity>  entities;
	private final App.Info          appInfo;
	private final Version           version;
	private final Scripts           scripts;
	private final WorkingDirectory  workingDirectory;

	@Override
	public void generate() {

		fileSystemService.createDirectory(
				workingDirectory.getBackendSpringBootDirectory()
		);

		processStaticContent();

		processAppTemplates();

		processEntityTemplates();

		if (appComponents.getBackend().getSpringBoot().isDockerfile())
			addDocker();

		// git should be last
		if (appComponents.getBackend().getSpringBoot().isGitInit())
			addGit();

	}

	private void processStaticContent() {

		final Consumer<BinaryResource> setOutputPath = resource -> {

			final String relativePath = resource.getRelativePath().toString();
			resource.setOutputPath(
					workingDirectory
							.getBackendSpringBootDirectory()
							.resolve(relativePath)
							.toAbsolutePath()
			);

		};

		fileSystemService
				.listResources(ResourceFolder.backend_springboot_static_content)
				.stream()
				.peek(resource -> log.info("Input: " + resource.getRelativePath()))
				.peek(setOutputPath)
				.peek(resource -> log.info("Output: " + resource.getOutputPath()))
				.forEach(fileSystemService::create);

	}

	private void processAppTemplates() {

		final Consumer<AppTemplate> setOutputPath = resourceFile -> {

			final String relativePath = resourceFile
					.getRelativePath()
					.toString()
					.replace(
							PathKey.GROUPID.name(),
							ClassUtils.convertClassNameToResourcePath(appInfo.getGroupId())
					);

			resourceFile.setOutputPath(
					workingDirectory
							.getBackendSpringBootDirectory()
							.resolve(StringUtils.stripFilenameExtension(relativePath))
							.toAbsolutePath()
			);

		};

		var map = Map.of(
				TemplateKey.info, appInfo,
				TemplateKey.entities, entities,
				TemplateKey.workingDirectory, workingDirectory,
				TemplateKey.version, version
		);

		fileSystemService
				.listTemplates(ResourceFolder.backend_springboot_app)
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

	private void processEntityTemplates() {

		final BiConsumer<AppTemplate, App.Entity> setOutputPath = (template, entity) -> {

			final String relativePath = template
					.getRelativePath()
					.toString()
					.replace(PathKey.GROUPID.name(), ClassUtils.convertClassNameToResourcePath(appInfo.getGroupId()))
					.replace(PathKey.ENTCAMEL.name(), entity.getName().getSingular().toString())
					.replace(PathKey.ENTKEBAB.name(), entity.getName().getSingular().getKebab().toString())
					.replace(PathKey.ENTPASCAL.name(), entity.getName().getSingular().getPascal().toString());

			template.setOutputPath(
					workingDirectory
							.getBackendSpringBootDirectory()
							.resolve(StringUtils.stripFilenameExtension(relativePath))
							.toAbsolutePath()
			);

		};

		List<AppTemplate> templates = fileSystemService.listTemplates(ResourceFolder.backend_springboot_entities);
		entities.forEach(
				entity -> templates
						.stream()
						.peek(binaryResource -> log.info("Input: " + binaryResource.getRelativePath().toString()))
						.peek(binaryResource -> setOutputPath.accept(binaryResource, entity))
						.peek(binaryResource -> log.info("Output: " + binaryResource.getOutputPath()))
						.peek(
								template -> template.setOutputContent(
										templateProcessor.process(
												template.getContent(),
												Map.of(
														TemplateKey.info, appInfo,
														TemplateKey.entity, entity,
														TemplateKey.workingDirectory, workingDirectory
												)
										)
								)
						)
						.forEach(fileSystemService::create)
		);

	}

	public void addDocker() {

		final ResourceFolder resourceFolder = ResourceFolder.backend_springboot_docker;
		final Consumer<AppTemplate> setOutputPath = resourceFile -> {

			final String relativePath = resourceFile.getRelativePath().toString();
			resourceFile.setOutputPath(
					workingDirectory
							.getBackendSpringBootDirectory()
							.resolve(StringUtils.stripFilenameExtension(relativePath))
							.toAbsolutePath()
			);

		};

		final Map<TemplateKey, Object> map = Map.of(
				TemplateKey.info, appInfo,
				TemplateKey.version, version
		);

		fileSystemService
				.listTemplates(resourceFolder)
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

	public void addGit() {

		FileUtil.run(
				scripts.getGit(),
				workingDirectory.getBackendSpringBootDirectory()
		);

	}

}