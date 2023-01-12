package ${ info.groupId }.exception.handler;

import ${ info.groupId }.entity.ErrorDTO;
import ${ info.groupId }.exception.InvalidJWTTokenException;
import ${ info.groupId }.exception.UserAlreadyExistsException;
import io.swagger.v3.oas.annotations.Operation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@ControllerAdvice
public class AuthExceptionHandler {

    @Operation(summary = "Handles AccessDeniedException")
    @ExceptionHandler
    public final ResponseEntity<ErrorDTO> handle(AccessDeniedException ex, WebRequest request) {

        log.info(request.toString());
        return httpStatusUNAUTHORIZED(ex, "Access Denied");

    }

    @Operation(summary = "Handles InvalidJWTTokenException")
    @ExceptionHandler
    public final ResponseEntity<ErrorDTO> handle(InvalidJWTTokenException ex, WebRequest request) {

        return httpStatusUNAUTHORIZED(ex, "Login required");

    }

    @Operation(summary = "Handles BadCredentialsException")
    @ExceptionHandler
    public final ResponseEntity<ErrorDTO> handle(BadCredentialsException ex, WebRequest request) {

        return httpStatusUNAUTHORIZED(ex, "Incorrect username or password");

    }

    @Operation(summary = "Handles (Account) LockedException")
    @ExceptionHandler
    public final ResponseEntity<ErrorDTO> handle(LockedException ex, WebRequest request) {

        return httpStatusUNAUTHORIZED(ex, "Account is locked");

    }

    @Operation(summary = "Handles (Account) DisabledException")
    @ExceptionHandler
    public final ResponseEntity<ErrorDTO> handle(DisabledException ex, WebRequest request) {

        return httpStatusUNAUTHORIZED(ex, "Account is disabled");

    }

    @Operation(summary = "Handles AccountExpiredException")
    @ExceptionHandler
    public final ResponseEntity<ErrorDTO> handle(AccountExpiredException ex, WebRequest request) {

        return httpStatusUNAUTHORIZED(ex, "Account is expired");

    }

    @Operation(summary = "Handles InternalAuthenticationServiceException")
    @ExceptionHandler
    public final ResponseEntity<ErrorDTO> handle(InternalAuthenticationServiceException ex, WebRequest request) {

        return httpStatusUNAUTHORIZED(ex, "Internal error");

    }

    @Operation(summary = "Handles CredentialsExpiredExceptions")
    @ExceptionHandler
    public final ResponseEntity<ErrorDTO> handle(CredentialsExpiredException ex, WebRequest request) {

        return httpStatusUNAUTHORIZED(ex, "Password expired");

    }

    private ResponseEntity<ErrorDTO> httpStatusUNAUTHORIZED(Exception ex, String error) {

        log.warn("AuthException: {}", ex.getClass().getSimpleName());
        log.debug("", ex);
        return new ResponseEntity<>(
                new ErrorDTO(ex.getClass().getSimpleName(), error),
                HttpStatus.UNAUTHORIZED
        );

    }

    @Operation(summary = "Handles UserAlreadyExistsException")
    @ExceptionHandler
    public final ResponseEntity<ErrorDTO> handle(UserAlreadyExistsException ex, WebRequest request) {

        return new ResponseEntity<>(
                new ErrorDTO("Username Taken", "User already exists"),
                HttpStatus.BAD_REQUEST
        );

    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<List<ErrorDTO>> handleValidationExceptions(MethodArgumentNotValidException ex) {

        // Map<String, String> errors = new HashMap<>();
        List<ErrorDTO> list = new ArrayList<>();
        ex
                .getBindingResult()
                .getAllErrors()
                .forEach((error) -> {

                    String fieldName    = ((FieldError) error).getField();
                    String errorMessage = error.getDefaultMessage();
                    list.add(new ErrorDTO(fieldName, errorMessage));
                    // errors.put(fieldName, errorMessage);

                });
        return new ResponseEntity<>(
                list,
                HttpStatus.BAD_REQUEST
        );

    }

}
