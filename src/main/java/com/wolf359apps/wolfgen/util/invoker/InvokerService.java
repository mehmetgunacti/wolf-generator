package com.wolf359apps.wolfgen.util.invoker;

import com.wolf359apps.wolfgen.model.Generator;

public interface InvokerService {

    void invoke(Class<? extends Generator> clazz);

}
