package com.wolf359apps.wolfgen.util.filesystem;

import com.wolf359apps.wolfgen.constants.ResourceFolder;
import com.wolf359apps.wolfgen.exception.FileSystemException;
import com.wolf359apps.wolfgen.model.AppTemplate;
import com.wolf359apps.wolfgen.model.BinaryResource;
import com.wolf359apps.wolfgen.util.FileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Slf4j
@RequiredArgsConstructor
@Service
public class FileSystemServiceImpl implements FileSystemService {

	private final Path classpathRoot;

	@Override
	public List<BinaryResource> listResources(ResourceFolder resourceFolder) {

		return listAllResources(resourceFolder, false)
				.stream()
				.map(
						resource -> new BinaryResource(
								FileUtil.getRelativePath(classpathRoot, resourceFolder, resource),
								FileUtil.getByteArray(resource)
						)
				)
				.collect(Collectors.toList());

	}

	@Override
	public List<AppTemplate> listTemplates(ResourceFolder resourceFolder) {

		return listAllResources(resourceFolder, true)
				.stream()
				.map(
						resource -> new AppTemplate(
								FileUtil.getRelativePath(classpathRoot, resourceFolder, resource),
								FileUtil.getString(resource)
						)
				)
				.collect(Collectors.toList());

	}

	private List<Resource> listAllResources(ResourceFolder resourceFolder, boolean filterTemplates) {

		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
		try {

			// "classpath:/templates/backend/app/ARTIFACTID-backend/src/main/asciidoc/api-guide.adoc.ftl"
			return Stream.of(
							resolver.getResources("classpath:/templates/" + resourceFolder.getPath() + "/**" + (filterTemplates ? "/*.ftl" : ""))
					)
					.filter(FileUtil::isFile)
					.collect(Collectors.toList());

		} catch (Exception e) {
			throw new FileSystemException(e);
		}

	}

	@Override
	public void create(BinaryResource binaryResource) {

		try {

			final Path outputPath = binaryResource.getOutputPath();
			Files.createDirectories(outputPath.getParent());
			Files.write(outputPath, binaryResource.getContent());

		} catch (IOException ioe) {
			throw new FileSystemException(ioe.getMessage(), ioe);
		}

	}

	@Override
	public void create(AppTemplate templateResource) {

		try {

			final Path outputPath = templateResource.getOutputPath();
			Files.createDirectories(outputPath.getParent());
			Files.writeString(outputPath, templateResource.getOutputContent());

		} catch (IOException ioe) {
			throw new FileSystemException(ioe.getMessage(), ioe);
		}

	}

	@Override
	public void createDirectory(Path path) {

		try {

			Files.createDirectories(path);

		} catch (IOException ioe) {
			throw new FileSystemException(ioe.getMessage(), ioe);
		}

	}

	@Override
	public void move(Path path, Path destination) {

		try {

			// Files.createDirectories(destination);
			Files.move(path, destination);

		} catch (IOException ioe) {
			throw new FileSystemException(ioe.getMessage(), ioe);
		}

	}

	//	@Override
//	public void copyFileToDirectory(String source, String destination) {
//
//		try {
//
//			FileUtils.copyFileToDirectory(
//					workingDirectory.getSubDirectory(source).toFile(),
//					workingDirectory.getSubDirectory(destination).toFile()
//			);
//
//		} catch (IOException ioe) {
//			log.error(ioe.getMessage(), ioe);
//			throw new FileSystemException();
//		}
//
//	}

//	@Override
//	public void copyToOutput(StaticContentFile staticContentFile) {
//
//		try {
//
//			File source      = staticContentFile.getResource().getFile();
//			File destination = workingDirectory.getSubDirectory(staticContentFile.getOutputFilePath()).toFile();
//			if (source.isDirectory())
//				FileUtils.copyDirectory(source, destination);
//			else
//				FileUtils.copyFileToDirectory(source, destination.getParentFile());
//
//		} catch (IOException ioe) {
//			throw new FileSystemException(ioe.getMessage(), ioe);
//		}
//
//	}

//	@Override
//	public void run(Scripts.CommandBundle commandBundle) {
//
//		// iterate over each 'command' and spawn() process
//		Optional.ofNullable(commandBundle)
//				.filter(Scripts.CommandBundle::isRun)
//				.map(Scripts.CommandBundle::getCommands)
//				.stream()
//				.flatMap(List::stream)
//				.filter(Scripts.CommandBundle.Command::isRun)
//				.forEach(command -> spawn(
//						Path.of(command.getSubdirectory()),
//						command.getCommand()
//				));
//
//	}

//	@Override
//	public void spawn(Path subDirectory, String... command) {
//
//		try {
//			File folder = workingDirectory.getPath().resolve(subDirectory).toFile();
//
//			// setup builder
//			ProcessBuilder builder = new ProcessBuilder(command);
//			builder.redirectErrorStream(true); // crucial
//			builder.directory(folder);
//
//			// start process
//			log.info("Starting process [" + folder.getAbsolutePath() + " " + String.join(" ", builder.command()) + "]");
//			final Process process = builder.start();
//			final long    pid     = process.pid();
//			log.info("Process started with PID " + pid);
//
//			// logging output
//			final String logPrefix = "['" + command[0] + "', PID:" + pid + "]";
//			logProcessOutput(logPrefix, process.getInputStream());
//
//			// wait for process to finish
//			int exitValue = process.waitFor();
//
//			// log result
//			log.info("Process with PID " + pid + " finished with value: " + exitValue);
//			if (exitValue != 0)
//				throw new FileSystemException(logPrefix + " Process finished with value: " + exitValue);
//
//		} catch (IOException | InterruptedException ioe) {
//			throw new FileSystemException(ioe);
//		}
//
//	}

//	private void logProcessOutput(String prefix, InputStream stream) throws IOException {
//
//		try (BufferedReader reader = new BufferedReader(new InputStreamReader(stream))) {
//
//			String line;
//			while ((line = reader.readLine()) != null)
//				log.info(prefix + " " + line);
//
//		}
//
//	}

//	@Override
//	public List<Resource> getTemplateFiles(ResourceFolder resourceFolder) {
//
//		return getTemplateFiles(resourceFolder, true);
//
//	}

//	@Override
//	public String readFileContent(File file) {
//
//		try {
//			return FileUtils.readFileToString(file, StandardCharsets.UTF_8);
//		} catch (IOException e) {
//			throw new FileSystemException(e);
//		}
//
//	}

//	@Override
//	public List<Resource> getTemplateFiles(ResourceFolder resourceFolder, boolean onlyTemplates) {
//
//		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
//		try {
//
//			return Arrays
//					.stream(
//							resolver.getResources(
//									"classpath:/templates/" + resourceFolder.getPath() + "/**" + (onlyTemplates ? "/*.ftl" : "")
//							)
//					)
//					.collect(Collectors.toList());
//
//		} catch (Exception e) {
//			throw new FileSystemException(e);
//		}
//
//	}

//	@Override
//	public List<Resource> getResources(ResourceFolder resourceFolder) {
//
//		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
//		try {
//
//			return Arrays.asList(
//					resolver.getResources(
//							"classpath:/templates/" + resourceFolder.getPath() + "/**"
//					)
//			);
//
//		} catch (Exception e) {
//			throw new FileSystemException(e);
//		}
//
//	}

//	public List<String> readFile(Path path) {
//
//		try {
//
//			return Files.readAllLines(
//					workingDirectory.getPath().resolve(path),
//					UTF_8
//			);
//
//		} catch (IOException e) {
//			throw new FileSystemException(e);
//		}
//
//	}

//	public void createFile(Path path, List<String> lines) {
//
//		try {
//
//			Files.write(
//					workingDirectory.getPath().resolve(path),
//					lines,
//					UTF_8
//			);
//
//		} catch (IOException e) {
//			throw new FileSystemException(e);
//		}
//
//	}

//	@Override
//	public void createFile(String relativePath, String content) {
//
//		try {
//
//			FileUtils.writeStringToFile(
//					workingDirectory.getSubDirectory(relativePath).toFile(),
//					content,
//					UTF_8
//			);
//
//		} catch (IOException e) {
//			throw new FileSystemException(e);
//		}
//
//	}

}

//    @Override
//    public void copyDirectory(String sourceDirectory, String artifactId) {
//
//        try {
//
////            for (
////                    File f :
////                    FileUtils.listFiles(
////                            new ClassPathResource(sourceDirectory).getFile(),
////                            null,
////                            true
////                    )
////            ) {
////
////                FileUtils.copyFileToDirectory(
////                        new File(
////                                new StaticFile(
////                                        f.getPath(),
////                                        artifactId
////                                ).getOutputFilePath()
////                        ),
////                        workingDirectory.asFile()
////                );
////
////            }
//            FileUtils.copyDirectory(
//                    new ClassPathResource(sourceDirectory).getFile(),
//                    workingDirectory.getSubDirectory(
//
//                            Optional.of(sourceDirectory)
//                                    .map(name -> name.replace(PathKey.ARTIFACTID.name(), artifactId))
//                                    .map(name -> name.substring((ResourceFolder.backend_static_content + "/").length()))
//                                    .get()
//
//                    ).toFile()
//            );
//
//        } catch (IOException ioe) {
//            throw new FileSystemException("Could not copy static directory.", ioe);
//        }
//
//    }