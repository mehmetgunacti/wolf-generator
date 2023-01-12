package ${ info.groupId }.exception;

import lombok.Getter;
import lombok.AllArgsConstructor;

@AllArgsConstructor
public class UserAlreadyExistsException extends RuntimeException {

	@Getter
	private final String username;

}
