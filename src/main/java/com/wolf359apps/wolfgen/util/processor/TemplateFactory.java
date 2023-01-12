package com.wolf359apps.wolfgen.util.processor;

import com.wolf359apps.wolfgen.constants.ResourceFolder;
import com.wolf359apps.wolfgen.exception.FileSystemException;
import com.wolf359apps.wolfgen.model.App;
import com.wolf359apps.wolfgen.model.AppTemplate;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

import java.io.File;
import java.nio.file.Path;

@Slf4j
@RequiredArgsConstructor
@Component
public class TemplateFactory {

	private final Path     classpathRoot;
	private final App.Info appInfo;

	public AppTemplate createAppTemplate(Resource resource) {
		return null; // new AppTemplate(resource);
	}

//	public EntityTemplate createEntityTemplate(Resource resource, App.Entity entity) {
//		return null; // new EntityTemplate(resource, entity);
//	}

//	public StaticContentFile createStaticContent(Resource resource) {
//
//		return new StaticContentFile(
//				FileUtil.getRelativePath(classpathRoot, resource),
//				FileUtil.getByteArray(resource),
//				appInfo
//		);
//
//	}

	public String extractRelativePath(Resource resource, ResourceFolder resourceFolder) {

		try {

			// if
			// uri is           : jar:file:/home/[...]/Projects/wolf-generator-app/wolf-generator/target/wolf-generator-1.0-SNAPSHOT.jar!/BOOT-INF/classes!/templates/app/backend/src/main/resources/mybatis-config.xml.ftl
			// and
			// classpathRoot is : jar:file:/home/[...]/Projects/wolf-generator-app/wolf-generator/target/wolf-generator-1.0-SNAPSHOT.jar!/BOOT-INF/classes!/
			// result should be : app/backend/src/main/resources/mybatis-config.xml.ftl
			return resource.getURI().toString().substring((classpathRoot + "templates" + File.separator + resourceFolder.getPath() + File.separator).length());

		} catch (Exception e) {
			throw new FileSystemException(resource.toString(), e);
		}

	}

}
