package com.wolf359apps.wolfgen.generator.randomdata;

import com.wolf359apps.wolfgen.model.Generator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class RandomDataGenerator implements Generator {

    @Override
    public void generate() {

        log.info("generate() of " + this.getClass().getSimpleName());

    }

}
