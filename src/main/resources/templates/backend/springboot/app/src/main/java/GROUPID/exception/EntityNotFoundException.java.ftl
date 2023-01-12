package ${ info.groupId }.exception;

import lombok.Getter;
import lombok.AllArgsConstructor;

@AllArgsConstructor
public class EntityNotFoundException extends RuntimeException {

	@Getter
	private final Long id;

}
