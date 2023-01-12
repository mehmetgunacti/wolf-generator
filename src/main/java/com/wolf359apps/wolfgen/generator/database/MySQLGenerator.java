package com.wolf359apps.wolfgen.generator.database;

import com.wolf359apps.wolfgen.constants.ResourceFolder;
import com.wolf359apps.wolfgen.constants.TemplateKey;
import com.wolf359apps.wolfgen.model.App;
import com.wolf359apps.wolfgen.model.AppTemplate;
import com.wolf359apps.wolfgen.model.DockerGenerator;
import com.wolf359apps.wolfgen.model.Generator;
import com.wolf359apps.wolfgen.model.GitGenerator;
import com.wolf359apps.wolfgen.model.RandomDataGenerator;
import com.wolf359apps.wolfgen.model.Scripts;
import com.wolf359apps.wolfgen.model.WorkingDirectory;
import com.wolf359apps.wolfgen.model.component.AppComponents;
import com.wolf359apps.wolfgen.util.FileUtil;
import com.wolf359apps.wolfgen.util.filesystem.FileSystemService;
import com.wolf359apps.wolfgen.util.processor.TemplateProcessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.function.Consumer;

@Slf4j
@RequiredArgsConstructor
@Component
public class MySQLGenerator implements Generator, GitGenerator, DockerGenerator, RandomDataGenerator {

	private final AppComponents     appComponents;
	private final List<App.Entity>  entities;
	private final App.Info          appInfo;
	private final Scripts           scripts;
	private final TemplateProcessor templateProcessor;
	private final FileSystemService fileSystemService;
	private final WorkingDirectory  workingDirectory;

	@Override
	public void generate() {

		fileSystemService.createDirectory(
				workingDirectory.getDatabaseMySQLDirectory()
		);

		processAppTemplates();

		if (appComponents.getDatabase().getMysql().isDockerfile())
			addDocker();

		if (appComponents.getDatabase().getMysql().isRandomData())
			addRandomData();

		// git should be last
		if (appComponents.getDatabase().getMysql().isGitInit())
			addGit();

	}

	private void processAppTemplates() {

		final Consumer<AppTemplate> setOutputPath = resourceFile -> {

			final String relativePath = resourceFile.getRelativePath().toString();
			resourceFile.setOutputPath(
					workingDirectory
							.getDatabaseMySQLDirectory()
							.resolve(StringUtils.stripFilenameExtension(relativePath))
							.toAbsolutePath()
			);

		};

		var map = Map.of(
				TemplateKey.info, appInfo,
				TemplateKey.entities, entities
		);

		fileSystemService
				.listTemplates(ResourceFolder.database_mysql_app)
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

	public void addDocker() {

		final ResourceFolder resourceFolder = ResourceFolder.database_mysql_docker;
		final Consumer<AppTemplate> setOutputPath = resourceFile -> {

			final String relativePath = resourceFile.getRelativePath().toString();
			resourceFile.setOutputPath(
					workingDirectory
							.getDatabaseMySQLDirectory()
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

	public void addRandomData() {
		log.warn("MySQLGenerator addRandomData() not implemented");
	}

	public void addGit() {

		FileUtil.run(
				scripts.getGit(),
				workingDirectory.getDatabaseMySQLDirectory()
		);

	}

}
