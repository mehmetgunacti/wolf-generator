package ${ info.groupId }.exception;

import lombok.Getter;
import lombok.AllArgsConstructor;

@AllArgsConstructor
public class EntityAlreadyExistsException extends RuntimeException {

	@Getter
	private final Long entityId;

}
