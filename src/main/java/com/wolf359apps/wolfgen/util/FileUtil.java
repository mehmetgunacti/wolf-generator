package com.wolf359apps.wolfgen.util;

import com.wolf359apps.wolfgen.constants.ResourceFolder;
import com.wolf359apps.wolfgen.exception.FileSystemException;
import com.wolf359apps.wolfgen.model.Scripts;
import com.wolf359apps.wolfgen.model.StaticContentBinary;
import com.wolf359apps.wolfgen.model.WorkingDirectory;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.Resource;
import org.springframework.util.FileCopyUtils;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Optional;

import static java.nio.charset.StandardCharsets.UTF_8;

@Slf4j
public class FileUtil {

	private static WorkingDirectory workingDirectory1;

	public static void copy(Path source, Path destinationDirectory) {

		try {

			Files.createDirectories(destinationDirectory);
			Files.copy(source, destinationDirectory.resolve(source.getFileName()));

		} catch (IOException e) {
			throw new FileSystemException(e);
		}

	}

//	public static void copyToOutput(StaticContentBinary staticContentFile) {
//
//		try {
//
//			Path source      = staticContentFile.getRelativePath();
//			Path destination = staticContentFile.getRelativePath();
//			if (Files.isDirectory(source))
//				Files.createDirectories(destination);
//			else {
//				Files.createDirectories(destination.getParent());
//				Files.copy(source, destination);
//			}
//
//		} catch (IOException ioe) {
//			throw new FileSystemException(ioe.getMessage(), ioe);
//		}
//
//	}

	public static void createFile(Path path, List<String> lines) {

		try {

			Files.write(path, lines, UTF_8);

		} catch (IOException e) {
			throw new FileSystemException(e);
		}

	}

//	public static void createFile(Path path, String content) {
//
//		try {
//
//			FileUtils.writeStringToFile(
//					path.toFile(),
//					content,
//					UTF_8
//			);
//
//		} catch (IOException e) {
//			throw new FileSystemException(e);
//		}
//
//	}

	public static List<String> readFile(Path path) {

		try {

			return Files.readAllLines(path, UTF_8);

		} catch (IOException e) {
			throw new FileSystemException(e);
		}

	}

	public static String readFileContent(Path file) {

		try {
			return FileUtils.readFileToString(file.toFile(), StandardCharsets.UTF_8);
		} catch (IOException e) {
			throw new FileSystemException(e);
		}

	}

//	public static List<ResourceFile> getResourceContents(ResourceFolder resourceFolder) {
//
//		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
//		try {
//
//			return Arrays.stream(
//							resolver.getResources(
//									"classpath:/templates/" + resourceFolder.getPath() + "/**"
//							)
//					)
//					.peek(f -> log.info("Resource" + f))
//					.filter(FileUtil::isFile)
//					.map(FileUtil::readResourceFile)
//					.collect(Collectors.toList());
//
//
//		} catch (Exception e) {
//			throw new FileSystemException(e);
//		}
//
//	}

//	private static ResourceFile readResourceFile(Resource resource) {
//
//		try {
//
//			return new StaticContentFile(
//					Path.of(resource.getURI()),
//					FileCopyUtils.copyToByteArray(resource.getInputStream())
//			);
//
//		} catch (IOException e) {
//			throw new FileSystemException(e);
//		}
//
//	}

	public static Path getRelativePath(Path classpathRoot, ResourceFolder resourceFolder, Resource resource) {

		try {

			return classpathRoot
					.resolve("templates")
					.resolve(resourceFolder.getPath())
					.relativize(
							Path.of(resource.getURI().toString())
					);

		} catch (IOException e) {
			throw new FileSystemException(e);
		}

	}

	public static byte[] getByteArray(Resource resource) {

		try {

			return FileCopyUtils.copyToByteArray(resource.getInputStream());

		} catch (IOException e) {
			throw new FileSystemException(e);
		}

	}

	public static String getString(Resource resource) {

		try {

			return new String(FileCopyUtils.copyToByteArray(resource.getInputStream()));

		} catch (IOException e) {
			throw new FileSystemException(e);
		}

	}

	/*
	 * Careful:
	 * URI = org.springframework.core.io.ClassPathResource.getURI().toString():
	 * If URI starts with ...
	 *
	 * ... "jar:file:": <- zip file
	 * 1) file example:
	 *    jar:file:/home/[..]/wolfgen.jar!/BOOT-INF/classes!/templates/[..]/.mvn/wrapper/maven-wrapper.jar
	 * 2) directory example:
	 *    jar:file:/home/[..]/wolfgen.jar!/BOOT-INF/classes!/templates/[..]/.mvn/wrapper/
	 * -> if the resource is a directory Spring returns a "/" as last character
	 *    -> return true if URI ends with a "/"
	 *
	 * ... "file:": <- resource exists on file system
	 * 1) file example:
	 *    file:/home/[..]/wolf-generator/target/classes/templates/[..]/wrapper/maven-wrapper.properties
	 * 2) directory example:
	 *    file:/home/[..]/wolf-generator/target/classes/templates/[..]/wrapper
	 * -> return resource.getFile().isFile()
	 */
	public static boolean isFile(final Resource resource) {

		try {

			final String uri = resource.getURI().toString();
			if (uri.startsWith("jar:file:"))
				return !resource.getURI().toString().endsWith("/");

			if (uri.startsWith("file:"))
				return resource.getFile().isFile();

			throw new FileSystemException("Unhandled case: " + uri);

		} catch (IOException e) {
			throw new FileSystemException(e);
		}

	}

	public static void run(Scripts.CommandBundle commandBundle, final Path path) {

		// iterate over each 'command' and spawn() process
		Optional.ofNullable(commandBundle)
				.map(Scripts.CommandBundle::getCommands)
				.stream()
				.flatMap(List::stream)
				.filter(Scripts.CommandBundle.Command::isRun)
				.forEach(command -> spawn(
						StringUtils.isBlank(command.getDirectory()) ? path : path.resolve(command.getDirectory()),
						command.getCommand()
				));

	}

	private static void spawn(Path path, String... command) {

		try {
			File folder = path.toFile();

			// setup builder
			ProcessBuilder builder = new ProcessBuilder(command);
			builder.redirectErrorStream(true); // crucial for logging
			builder.directory(folder);

			// start process
			log.info("Starting process [" + folder.getAbsolutePath() + File.separator + String.join(" ", builder.command()) + "]");
			final Process process = builder.start();
			final long    pid     = process.pid();
			log.info("Process started with PID " + pid);

			// logging output
			final String logPrefix = "['" + command[0] + "', PID:" + pid + "]";
			logProcessOutput(logPrefix, process.getInputStream());

			// wait for process to finish
			int exitValue = process.waitFor();

			// log result
			log.info("Process with PID " + pid + " finished with value: " + exitValue);
			if (exitValue != 0)
				throw new FileSystemException(logPrefix + " Process finished with value: " + exitValue);

		} catch (IOException | InterruptedException ioe) {
			throw new FileSystemException(ioe);
		}

	}

	private static void logProcessOutput(String prefix, InputStream stream) throws IOException {

		try (BufferedReader reader = new BufferedReader(new InputStreamReader(stream))) {

			String line;
			while ((line = reader.readLine()) != null)
				log.info(prefix + " " + line);

		}

	}

}
