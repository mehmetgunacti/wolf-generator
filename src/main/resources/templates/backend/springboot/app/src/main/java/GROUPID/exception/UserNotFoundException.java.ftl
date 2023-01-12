package ${ info.groupId }.exception;

import java.util.Optional;

public class UserNotFoundException extends RuntimeException {

	public UserNotFoundException(String username) {

		super("User with username " + username + " not found");

	}

	public UserNotFoundException(Long id) {

		super("User with id " + Optional.ofNullable(id).map(Object::toString).orElse("N/A") + " not found");

	}

}
