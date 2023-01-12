package ${ info.groupId }.entity.email;

import ${ info.groupId }.configuration.AppConfiguration;
import ${ info.groupId }.constant.EmailType;
import ${ info.groupId }.entity.BaseEntity;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.File;
import java.time.Instant;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Component
public class EmailServiceImpl implements EmailService {

    private static final Integer EMAIL_MAX_RETRY = 3;

    private final JavaMailSender   emailSender;
    private final AppConfiguration appConfiguration;
    private final EmailMapper      emailMapper;

    public Email find(EmailType emailType, Instant now) {

        return emailMapper.find(emailType, now);

    }

    @Override
    @Transactional
    public Email create(Email email) {

        emailMapper.insert(email);
        for (BaseEntity recipient : email.getRecipients())
            emailMapper.insertRecipients(recipient.getId(), email.getId());

        return email;

    }

    public void updateSent(Long id, Instant now) {

        emailMapper.updateSent(id, now);

    }

    public void increaseRetry(Long id) {

        emailMapper.increaseRetry(id);

    }

    public List<Email> findRecipients() {

        List<Email> emails = emailMapper.findOutgoing(EMAIL_MAX_RETRY);
        for (Email email : emails)
            email.setRecipients(emailMapper.findRecipients(email.getId()));

        return emails;

    }

    public void prepareAndSend(Email email) {

        // TODO: refactor emailserviceimpl to behave appropriate to the environment, look at falke proj

        MimeMessagePreparator messagePreparator = mimeMessage -> {
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage);
            String            recipients    = "wolf359apps@gmail.com";
            messageHelper.setTo(recipients);
            // System.out.println("Sending mail to : " + alicilar);
            messageHelper.setSubject(email.getSubject());
            messageHelper.setText(email.getContent(), true);
        };
        emailSender.send(messagePreparator);

    }

    @Override
    public void sendMessageWithAttachment(String to,
                                          String subject,
                                          String text,
                                          String pathToAttachment) {

        try {

            MimeMessage message = emailSender.createMimeMessage();
            // pass 'true' to the constructor to create a multipart message
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(text);

            FileSystemResource file = new FileSystemResource(new File(pathToAttachment));
            helper.addAttachment("Invoice", file);

            emailSender.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }

    }

}
