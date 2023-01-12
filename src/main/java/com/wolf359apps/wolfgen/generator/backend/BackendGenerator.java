package com.wolf359apps.wolfgen.generator.backend;

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
public class BackendGenerator implements Generator {

	private final InvokerService    invokerService;
	private final FileSystemService fileSystemService;
	private final WorkingDirectory  workingDirectory;

	@Override
	public void generate() {

		fileSystemService.createDirectory(
				workingDirectory.getBackendDirectory()
		);

		invokerService.invoke(SpringBootProjectGenerator.class);

	}

}