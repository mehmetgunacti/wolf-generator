package com.wolf359apps.wolfgen.model;

import org.apache.commons.lang3.NotImplementedException;

public interface Generator {

    default void cleanup() {

        // do nothing

    }

    default void generate() {

        generate(null);

    }

    default void generate(App.Entity entity) {

        throw new NotImplementedException();

    }

}
