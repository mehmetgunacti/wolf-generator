package com.wolf359apps.wolfgen.exception;

public class FileSystemException extends RuntimeException {

    public FileSystemException() {
        super();
    }

    public FileSystemException(String message) {
        super(message);
    }

    public FileSystemException(Throwable throwable) {
        super(throwable);
    }

    public FileSystemException(String message, Throwable throwable) {
        super(message, throwable);
    }

}
