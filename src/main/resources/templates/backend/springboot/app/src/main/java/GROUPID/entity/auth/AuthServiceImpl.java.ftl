package ${ info.groupId }.entity.auth;

import ${ info.groupId }.configuration.AppConfiguration;
import ${ info.groupId }.constant.EmailType;
import ${ info.groupId }.entity.email.Email;
import ${ info.groupId }.entity.email.EmailService;
import ${ info.groupId }.exception.UserNotFoundException;
import ${ info.groupId }.util.PwdUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.Set;

@Slf4j
@RequiredArgsConstructor
@Service
public class AuthServiceImpl implements AuthService {

    private final AuthUserMapper        authUserMapper;
    private final AuthMapper            authMapper;
    private final BCryptPasswordEncoder bcryptEncoder;
    private final EmailService          emailService;
    private final AppConfiguration      appConfiguration;

    @Override
    @Transactional
    public void remindPassword(String username) {

        AuthUser user = authUserMapper
                .findByUsername(username)
                .orElseThrow(() -> new UserNotFoundException(username));

        String random = PwdUtil.generate();
        user.setPassword(bcryptEncoder.encode(random));
        user.setPasswordExpiration(Instant.now());
        authMapper.remindPassword(user);

        Email email = Email.builder()
                .emailType(EmailType.REMIND_PASSWORD)
                .subject("Şifre talebiniz hk.")
                .content("Sayın " + user.getName() + ", yeni şifreniz " + random + " olarak belirlendi. Kimseyle paylaşmayınız.")
                .created(Instant.now())
                .retry(0)
                .recipients(Collections.singletonList(user))
                .build();
        emailService.create(email);

    }

    @Override
    @Transactional
    public void changePassword(String username, String password) {

        AuthUser user = authUserMapper
                .findByUsername(username)
                .orElseThrow(() -> new UserNotFoundException(username));

        authMapper.changePassword(
                user.getUsername(),
                bcryptEncoder.encode(password),
                Instant.now().plus(appConfiguration.getDefaultPasswordExpiration(), ChronoUnit.DAYS)
        );

        Email email = Email.builder()
                .emailType(EmailType.CHANGE_PASSWORD)
                .subject("Şifre değişikliği hk.")
                .content(user.getName() + ", şifreniz başarıyla değiştirildi.")
                .created(Instant.now())
                .retry(0)
                .recipients(Collections.singletonList(user))
                .build();
        emailService.create(email);

    }

    @Override
    @Transactional
    public void enableAccount(Long userId) {

        AuthUser user = new AuthUser();
        user.setId(userId);
        user.setAccountExpiration(Instant.now().plus(appConfiguration.getDefaultAccountExpiration(), ChronoUnit.DAYS));
        authUserMapper.update(user);

    }

    @Override
    @Transactional
    public void disableAccount(Long userId) {

        authMapper.disableAccount(userId);

    }

    @Override
    @Transactional
    public void toggleRole(Long userId, String role) {

        Set<String> authorities = authUserMapper.findRolesByUserId(userId);
        if (authorities.contains(role))
            authMapper.revokeRole(userId, role);
        else
            authMapper.grantRole(userId, role);

    }

    @Override
    @Transactional
    public void grantRole(Long userId, String role) {

        authMapper.grantRole(userId, role);

    }

    @Override
    @Transactional
    public void revokeRole(Long userId, String role) {

        authMapper.revokeRole(userId, role);

    }

}
