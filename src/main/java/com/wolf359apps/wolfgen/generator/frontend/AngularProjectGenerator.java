package com.wolf359apps.wolfgen.generator.frontend;

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
import com.wolf359apps.wolfgen.model.WorkingDirectory;
import com.wolf359apps.wolfgen.model.component.AppComponents;
import com.wolf359apps.wolfgen.util.FileUtil;
import com.wolf359apps.wolfgen.util.filesystem.FileModifierService;
import com.wolf359apps.wolfgen.util.filesystem.FileSystemService;
import com.wolf359apps.wolfgen.util.processor.TemplateProcessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.ClassUtils;
import org.springframework.util.StringUtils;

import java.nio.file.Path;
import java.util.List;
import java.util.Map;
import java.util.function.BiConsumer;
import java.util.function.Consumer;

@Slf4j
@RequiredArgsConstructor
@Component
public class AngularProjectGenerator implements Generator, GitGenerator, DockerGenerator {

	private final FileSystemService   fileSystemService;
	private final FileModifierService fileModifierService;
	private final TemplateProcessor   templateProcessor;
	private final AppComponents       appComponents;
	private final App.Info            appInfo;
	private final List<App.Entity>    entities;
	private final Scripts             scripts;
	private final WorkingDirectory    workingDirectory;

	@Override
	public void generate() {

		fileSystemService.createDirectory(
				workingDirectory.getFrontendAngularDirectory()
		);

		// init angular
		FileUtil.run(
				scripts.getAngular(),
				workingDirectory.getFrontendAngularDirectory()
		);

		// modifyEnvironmentTs();

		// modifyEnvironmentDevelopmentTs();

		modifyTSConfigJson();

		copyPrimeThemes();

		increaseBudget();

		disableInlineCriticalForCSS();

		processStaticContent();

		processAppTemplates();

		processEntityTemplates();

		if (appComponents.getFrontend().getAngular().isDockerfile())
			addDocker();

		// git should be last
		if (appComponents.getFrontend().getAngular().isGitInit())
			addGit();


	}

//	private void modifyEnvironmentTs() {
//
//		final List<String> lines = new ArrayList<>();
//		lines.add("export const environment = {");
//		lines.add("\tproduction: true");
//		lines.add("\tbackendUrl: 'http://localhost:8080'");
//		lines.add("};");
//
//		final Path target = workingDirectory
//				.getFrontendAngularDirectory()
//				.resolve(
//						Path.of("src", "environments", "environment.ts")
//				);
//
//		// save file
//		FileUtil.createFile(target, lines);
//
//	}
//
//	private void modifyEnvironmentDevelopmentTs() {
//
//		final List<String> lines = new ArrayList<>();
//		lines.add("export const environment = {");
//		lines.add("\tproduction: false");
//		lines.add("\tbackendUrl: 'http://localhost:8080'");
//		lines.add("};");
//
//		final Path target = workingDirectory
//				.getFrontendAngularDirectory()
//				.resolve(
//						Path.of("src", "environments", "environment.development.ts")
//				);
//
//		// save file
//		FileUtil.createFile(target, lines);
//
//	}

	private void modifyTSConfigJson() {

		fileModifierService.replaceLine(
				workingDirectory.getFrontendAngularDirectory().resolve("tsconfig.json"),
				"    \"baseUrl\": \"./\",",
				"    \"baseUrl\": \"./src\","
		);

	}

//	private void modifyTSLintJson() {
//
//		final Path tsLint = workingDirectory
//				.getFrontendAngularDirectory()
//				.resolve(
//						Path.of("tslint.json")
//				);
//		final List<String> lines = FileUtil.readFile(tsLint);
//
//		// replace "curly"
//		fileModifierService.replaceLine(
//				lines,
//				"    \"curly\": true,",
//				"    \"curly\": false,"
//		);
//
//		// replace indentation
//		fileModifierService.replaceLine(
//				lines,
//				new String[]{
//						"    \"indent\": {",
//						"      \"options\": [",
//						"        \"spaces\""
//				},
//				"        \"tabs\""
//		);
//
//		// replace indentation
//		fileModifierService.replaceLine(
//				lines,
//				new String[]{
//						"    \"max-line-length\": [",
//						"      true,",
//						"      140"
//				},
//				"      999"
//		);
//
//		// save file
//		FileUtil.createFile(tsLint, lines);
//
//	}

	private void copyPrimeThemes() {

		final Path angularDir = workingDirectory.getFrontendAngularDirectory();
		FileUtil.copy(
				angularDir.resolve(
						Path.of("node_modules", "primeng", "resources", "themes", "arya-blue", "theme.css")
				),
				angularDir.resolve(
						Path.of("src", "assets", "themes", "arya-blue")
				)
		);

		FileUtil.copy(
				angularDir.resolve(
						Path.of("node_modules", "primeng", "resources", "themes", "saga-blue", "theme.css")
				),
				angularDir.resolve(
						Path.of("src", "assets", "themes", "saga-blue")
				)
		);

	}

	private void increaseBudget() {

		final Path         tsLint = workingDirectory.getFrontendAngularDirectory().resolve("angular.json");
		final List<String> lines  = FileUtil.readFile(tsLint);
		fileModifierService.replaceLine(
				lines,
				new String[]{
						"                  \"type\": \"initial\",",
						"                  \"maximumWarning\": \"500kb\",",
						"                  \"maximumError\": \"1mb\""
				},
				"                  \"maximumError\": \"2mb\""
		);

		// save file
		FileUtil.createFile(tsLint, lines);

	}

	private void disableInlineCriticalForCSS() {

		final Path         angularJson = workingDirectory.getFrontendAngularDirectory().resolve("angular.json");
		final List<String> lines       = FileUtil.readFile(angularJson);
		fileModifierService.replaceLine(
				lines,
				new String[]{
						"            \"development\": {",
						"              \"buildOptimizer\": false,",
						"              \"optimization\": false,"
				},
				"              \"optimization\": { \"scripts\": true, \"styles\": { \"minify\": true, \"inlineCritical\": false }, \"fonts\": true },"
		);

		fileModifierService.addAfter(
				lines,
				"            \"production\": {",
				"              \"optimization\": { \"scripts\": true, \"styles\": { \"minify\": true, \"inlineCritical\": false }, \"fonts\": true },"
		);

		// save file
		FileUtil.createFile(angularJson, lines);

	}

	private void processStaticContent() {

		final Consumer<BinaryResource> setOutputPath = resource -> {

			final String relativePath = resource.getRelativePath().toString();
			resource.setOutputPath(
					workingDirectory
							.getFrontendAngularDirectory()
							.resolve(relativePath)
							.toAbsolutePath()
			);

		};

		fileSystemService
				.listResources(ResourceFolder.frontend_angular_static_content)
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
							.getFrontendAngularDirectory()
							.resolve(StringUtils.stripFilenameExtension(relativePath))
							.toAbsolutePath()
			);

		};

		var map = Map.of(
				TemplateKey.info, appInfo,
				TemplateKey.entities, entities,
				TemplateKey.workingDirectory, workingDirectory
		);

		fileSystemService
				.listTemplates(ResourceFolder.frontend_angular_app)
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
							.getFrontendAngularDirectory()
							.resolve(StringUtils.stripFilenameExtension(relativePath))
							.toAbsolutePath()
			);

		};

		List<AppTemplate> templates = fileSystemService.listTemplates(ResourceFolder.frontend_angular_entities);
		entities.forEach(
				entity -> templates.stream()
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

		final ResourceFolder resourceFolder = ResourceFolder.frontend_angular_docker;
		final Consumer<AppTemplate> setOutputPath = resourceFile -> {

			final String relativePath = resourceFile.getRelativePath().toString();
			resourceFile.setOutputPath(
					workingDirectory
							.getFrontendAngularDirectory()
							.resolve(StringUtils.stripFilenameExtension(relativePath))
							.toAbsolutePath()
			);

		};

		final Map<TemplateKey, Object> map = Map.of(
				TemplateKey.info, appInfo
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
				workingDirectory.getFrontendAngularDirectory()
		);

	}

}
