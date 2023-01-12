package com.wolf359apps.wolfgen;

import com.wolf359apps.wolfgen.generator.MainGenerator;
import com.wolf359apps.wolfgen.util.invoker.InvokerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@Slf4j
@RequiredArgsConstructor
@SpringBootApplication
public class MainApplication implements CommandLineRunner {

    private final InvokerService      invokerService;

    public static void main(String[] args) {

        SpringApplication.run(MainApplication.class, args);

    }

    @Override
    public void run(String... args) {

        invokerService.invoke(MainGenerator.class);

    }

}
