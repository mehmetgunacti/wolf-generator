package ${ info.groupId }.entity.email;

import ${ info.groupId }.constant.EmailType;
import ${ info.groupId }.service.EntityService;

import java.time.Instant;
import java.util.List;

public interface EmailService extends EntityService<Email, Long> {

	Email find(EmailType type, Instant now);

	void updateSent(Long id, Instant now);

	void increaseRetry(Long id);

	List<Email> findRecipients();

	void prepareAndSend(Email vo);

//	void sendSimpleMessageUsingTemplate(String to,
//										String subject,
//										SimpleMailMessage templateResource,
//										String... templateArgs);

	void sendMessageWithAttachment(String to,
								   String subject,
								   String text,
								   String pathToAttachment);

}