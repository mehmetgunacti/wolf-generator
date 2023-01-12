package com.wolf359apps.wolfgen.util.filesystem;

import com.wolf359apps.wolfgen.constants.ResourceFolder;
import com.wolf359apps.wolfgen.model.BinaryResource;
import com.wolf359apps.wolfgen.model.AppTemplate;

import java.nio.file.Path;
import java.util.List;

public interface FileSystemService {

	List<BinaryResource> listResources(ResourceFolder resourceFolder);

	List<AppTemplate> listTemplates(ResourceFolder resourceFolder);

	void create(BinaryResource binaryResource);

	void create(AppTemplate templateResource);
	void createDirectory(Path path);
	void move(Path path, Path destination);

	//    List<String> readFile(Path path);
//
//    void createFile(Path path, List<String> lines);
//
//    void createFile(String relativePath, String content);
//
//    void prepareWorkingDirectory();
//
//    void copyFileToDirectory(String source, String destination);
//
//    void copyToOutput(StaticContentFile staticContentFile);
//
//    void spawn(Path directory, String... command);
//
//    List<Resource> getResources(ResourceFolder resourceFolder);
//
//    List<Resource> getTemplateFiles(ResourceFolder resourceFolder, boolean onlyTemplates);
//
//    List<Resource> getTemplateFiles(ResourceFolder resourceFolder);
//
//    String readFileContent(File file);

}
