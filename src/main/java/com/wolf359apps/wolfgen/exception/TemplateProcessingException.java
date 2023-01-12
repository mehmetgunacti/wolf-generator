package com.wolf359apps.wolfgen.exception;

public class TemplateProcessingException extends RuntimeException {

    public TemplateProcessingException(String message, Throwable throwable) {
        super(message, throwable);
    }

    public TemplateProcessingException(String message) {
        super(message);
    }

}
