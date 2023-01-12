package com.wolf359apps.wolfgen.generator.database;

import com.wolf359apps.wolfgen.generator.backend.SpringBootProjectGenerator;
import com.wolf359apps.wolfgen.model.Generator;
import com.wolf359apps.wolfgen.model.WorkingDirectory;
import com.wolf359apps.wolfgen.util.filesystem.FileSystemService;
import com.wolf359apps.wolfgen.util.invoker.InvokerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@RequiredArgsConstructor
@Component
public class DatabaseGenerator implements Generator {

	private final InvokerService    invokerService;
	private final FileSystemService fileSystemService;
	private final WorkingDirectory  workingDirectory;

	@Override
	public void generate() {

		fileSystemService.createDirectory(
				workingDirectory.getDatabaseDirectory()
		);

		invokerService.invoke(MySQLGenerator.class);

	}

}
