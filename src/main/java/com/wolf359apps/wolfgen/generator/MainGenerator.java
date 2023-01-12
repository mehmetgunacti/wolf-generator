package com.wolf359apps.wolfgen.generator;

import com.wolf359apps.wolfgen.exception.FileSystemException;
import com.wolf359apps.wolfgen.generator.backend.BackendGenerator;
import com.wolf359apps.wolfgen.generator.database.DatabaseGenerator;
import com.wolf359apps.wolfgen.generator.docker.DockerComposeGenerator;
import com.wolf359apps.wolfgen.generator.frontend.FrontendGenerator;
import com.wolf359apps.wolfgen.model.component.AppComponents;
import com.wolf359apps.wolfgen.model.Generator;
import com.wolf359apps.wolfgen.model.WorkingDirectory;
import com.wolf359apps.wolfgen.util.filesystem.FileSystemService;
import com.wolf359apps.wolfgen.util.invoker.InvokerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.nio.file.Files;
import java.nio.file.Path;

@Slf4j
@RequiredArgsConstructor
@Component
public class MainGenerator implements Generator {

	private final FileSystemService fileSystemService;
	private final InvokerService    invokerService;
	//    private final Scripts           scripts;
//    private final App               app;
	private final WorkingDirectory  workingDirectory;
	private final AppComponents     appComponents;

	@Override
	public void cleanup() {

		// invokerService.invoke(DockerCleanupGenerator.class);

	}

	@Override
	public void generate() {

		// prepare working directory (backup existing)
		prepareWorkingDirectory();

		if (appComponents.getFrontend().isRun())
			invokerService.invoke(FrontendGenerator.class);

		if (appComponents.getBackend().isRun())
			invokerService.invoke(BackendGenerator.class);

		if (appComponents.getDatabase().isRun())
			invokerService.invoke(DatabaseGenerator.class);

		if (appComponents.getContainer().isRun())
			invokerService.invoke(DockerComposeGenerator.class);

//		if (appComponents.getRandomData().isRun())
//			invokerService.invoke(RandomDataGenerator.class);
//
//		if (appComponents.getGit().isRun())
//			invokerService.invoke(GitGenerator.class);

		// copy all files from static folder
		// fileSystemService.copyDirectory("statical/ARTIFACTID-backend", app.getInfo().getArtifactId());
		// fileSystemService.copyDirectory("statical/ARTIFACTID-frontend", app.getInfo().getArtifactId());
//        invokerService.invoke(StaticGenerator.class);
//
//        // create Angular Project
//        invokerService.invoke(AngularProjectGenerator.class);
//
//        // process templates (app)
//        invokerService.invoke(AppGenerator.class);
//
//        // process templates (entities)
//        invokerService.invoke(EntitiesGenerator.class);
//
//        // generate random data
//        invokerService.invoke(RandomDataEntitiesGenerator.class);
//
//        // create backend.jar
//        fileSystemService.run(scripts.getMaven());
//
//        // build angular
//        fileSystemService.run(scripts.getBuildAngular());
//
//        // run Docker
//        fileSystemService.run(scripts.getDockerStart());
//
//        // init git
//        fileSystemService.run(scripts.getGit());

	}

	private void prepareWorkingDirectory() {

		try {

			final Path project = workingDirectory.getProjectFolder();
			if (Files.exists(project))
				backupDirectory(project);
			fileSystemService.createDirectory(project);

		} catch (SecurityException ioe) {
			throw new FileSystemException();
		}

	}

	private void backupDirectory(Path projectFolder) {

		final String newDirectoryName = projectFolder.getFileName() + "_" + System.currentTimeMillis();
		log.info("Project directory already exists. Renaming to '%s'.".formatted(newDirectoryName));

		fileSystemService.move(
				projectFolder,
				workingDirectory.getPath().resolve(newDirectoryName)
		);

	}

}
