package com.wolf359apps.wolfgen.exception;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class InvalidConfigurationException extends RuntimeException {

    public InvalidConfigurationException(String message) {
        super(message);
    }

    public InvalidConfigurationException(String message, Throwable cause) {
        super(message, cause);
    }

}
