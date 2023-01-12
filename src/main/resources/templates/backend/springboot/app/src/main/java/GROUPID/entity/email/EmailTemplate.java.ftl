package ${ info.groupId }.entity.email;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
public abstract class EmailTemplate {

	@Getter
	protected String templateName;

}
