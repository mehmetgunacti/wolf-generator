package com.wolf359apps.wolfgen.util.processor;

import com.wolf359apps.wolfgen.constants.TemplateKey;
import com.wolf359apps.wolfgen.model.AppTemplate;

import java.util.Map;

public interface TemplateProcessor {

	// void process(AppTemplate template, Map<>);
	// void process(EntityTemplate entityTemplate);
	String process(String content, Map<TemplateKey, Object> parameters);

}