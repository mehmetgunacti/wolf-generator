package ${ info.groupId }.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@AllArgsConstructor
public class HTTPException extends RuntimeException {

	@Getter
	protected HttpStatus httpStatus;

	@Getter
	protected String message;

	public HTTPException(HttpStatus httpStatus) {

		this(httpStatus, "");

	}

}
