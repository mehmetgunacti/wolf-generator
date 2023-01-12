package ${ info.groupId }.entity.email;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

@RequiredArgsConstructor
@Service
public class EmailContentBuilder {

	private final TemplateEngine templateEngine;

	public String build(EmailTemplate mail) {

		Context context = new Context();
		context.setVariable("mail", mail);
		return templateEngine.process(mail.getTemplateName(), context);

	}

}