package com.wolf359apps.wolfgen.util.invoker;

import com.wolf359apps.wolfgen.model.Generator;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class InvokerServiceImpl implements InvokerService {

    private final ApplicationContext applicationContext;

    @Override
    public void invoke(Class<? extends Generator> clazz) {

        log.info(" ");
        log.info("****************************************************************");
        log.info("* Generator: " + clazz.getSimpleName());
        log.info("****************************************************************");

        Generator generator = applicationContext.getBean(clazz);

        // cleanup
        generator.cleanup();

        // generate
        generator.generate();

    }

}
