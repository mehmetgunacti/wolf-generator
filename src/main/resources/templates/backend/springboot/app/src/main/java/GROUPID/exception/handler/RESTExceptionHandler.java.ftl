package ${ info.groupId }.exception.handler;

import ${ info.groupId }.entity.BaseDTO;
import io.swagger.v3.oas.annotations.Operation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@Slf4j
@ControllerAdvice
public class RESTExceptionHandler extends ResponseEntityExceptionHandler {

	@Operation(summary = "Handles Exception")
	@ExceptionHandler
	public final ResponseEntity<String> handle(Exception ex, WebRequest request) {

		log.debug(ex.getClass().getSimpleName());
		log.error("INTERNAL_SERVER_ERROR :", ex);
        return new ResponseEntity<>(
                "INTERNAL_SERVER_ERROR",
                HttpStatus.INTERNAL_SERVER_ERROR
        );

	}

//	@Operation(summary = "Handles EntityNotFoundException")
//	@ExceptionHandler
//	public final ResponseEntity<BaseDTO> handle(EntityNotFoundException ex, WebRequest request) {
//
//		log.debug(ex.getClass().getSimpleName());
//		log.warn("EntityNotFoundException :", ex);
//		return new ResponseEntity<>(
//				ex.getDto(),
//				HttpStatus.OK
//		);
//
//	}

//	@Operation(summary = "Return HTTP status...")
//	@ExceptionHandler
//	public final ResponseEntity<String> handle(HTTPException ex, WebRequest request) {
//
//		log.debug(ex.getClass().getSimpleName());
//		return new ResponseEntity<>(
//				ex.getMessage(),
//				ex.getHttpStatus()
//		);
//
//	}

//	@Operation(summary = "Hesap disabled...")
//	@ExceptionHandler
//	public final ResponseEntity<String> handle(DisabledException ex, WebRequest request) {
//
//		log.debug(ex.getClass().getSimpleName());
//		return new ResponseEntity<>(
//				"AccountDisabled",
//				HttpStatus.UNAUTHORIZED
//		);
//
//	}
//
//	@Operation(summary = "İlk kez şifre alındığında...")
//	@ExceptionHandler
//	public final ResponseEntity<String> handle(AccountExpiredException ex, WebRequest request) {
//
//		log.debug(ex.getClass().getSimpleName());
//    	return new ResponseEntity<>(
//				"AccountExpired",
//				HttpStatus.UNAUTHORIZED
//		);
//
//	}
//
//	@Operation(summary = "İlk kez şifre alındığında...")
//	@ExceptionHandler
//	public final ResponseEntity<String> handle(CredentialsExpiredException ex, WebRequest request) {
//
//		log.debug(ex.getClass().getSimpleName());
//		return new ResponseEntity<>(
//				"CredentialsExpired",
//				HttpStatus.UNAUTHORIZED
//		);
//
//	}
//
//	@Operation(summary = "Kullanıcı adı veya şifre yanlış girildiğinde...")
//	@ExceptionHandler
//	public final ResponseEntity<String> handle(BadCredentialsException ex, WebRequest request) {
//
//		log.debug(ex.getClass().getSimpleName());
//		return new ResponseEntity<>(
//				"BadCredentials",
//				HttpStatus.UNAUTHORIZED
//		);
//
//	}
//
//	@ExceptionHandler
//	public final ResponseEntity<String> handle(AppException ex) {
//		log.debug(ex.getClass().getSimpleName());
//
//		return new ResponseEntity(
//				new ErrorResponse(
//						ex.getMessage(),
//						ErrorResponseActions.allow
//				),
//				ex.getHttpStatus()
//		);
//	}
//
//	@ExceptionHandler
//	protected ResponseEntity<Object> handle(ConstraintViolationException ex) {
//		log.debug(ex.getClass().getSimpleName());
//
//		return handleBadRequest(
//				ex
//						.getConstraintViolations()
//						.stream()
//						.map(ConstraintViolation::getMessage)
//						.collect(Collectors.toList())
//		);
//	}
//
//	@Override
//	protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
//
//		log.debug(ex.getClass().getSimpleName());
//		return handleBadRequest(
//				ex
//						.getBindingResult()
//						.getAllErrors()
//						.stream()
//						.map(ObjectError::getDefaultMessage)
//						.collect(Collectors.toList())
//		);
//
//	}
//
//	private ResponseEntity<Object> handleBadRequest(List<String> details) {
//
//		if (details != null)
//			for (String s: details)
//				log.debug(s);
//
//		return new ResponseEntity<>(
//				HttpStatus.BAD_REQUEST,
//				HttpStatus.BAD_REQUEST
//		);
//
//	}

}
