package com.wolf359apps.wolfgen.generator.docker;

import com.wolf359apps.wolfgen.model.Generator;
import com.wolf359apps.wolfgen.model.Scripts;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@RequiredArgsConstructor
@Component
public class DockerCleanupGenerator implements Generator {

    private final Scripts           scripts;

    @Override
    public void cleanup() {

        Scripts.CommandBundle docker = scripts.getDockerCleanup();
//        if (docker.isRun())
//            if (
//                    FileUtil.exists(
//                            Path.of("docker-compose.yaml"),
//                            Path.of("backend", "Dockerfile"),
//                            Path.of("frontend", "Dockerfile"),
//                            Path.of("resources", "mysql.dockerfile")
//                    )
//            )
//                fileSystemService.run(docker);
//            else
//                log.info("Skipping docker-compose cleanup: configuration file(s) not available.");

    }

    @Override
    public void generate() {

        // do nothing

    }

}
