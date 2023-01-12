package ${ info.groupId }.entity.auth;

import ${ info.groupId }.configuration.AppConfiguration;
import ${ info.groupId }.constant.Constants;
import ${ info.groupId }.constant.EmailType;
import ${ info.groupId }.entity.email.Email;
import ${ info.groupId }.entity.email.EmailService;
import ${ info.groupId }.exception.UserAlreadyExistsException;
import ${ info.groupId }.util.PwdUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Service
public class AuthUserServiceImpl implements AuthUserService {

    private final AuthUserMapper        authUserMapper;
    private final AuthMapper            authMapper;
    private final BCryptPasswordEncoder bcryptEncoder;
    private final EmailService          emailService;
    private final AppConfiguration      appConfiguration;

    @Override
    public List<AuthUser> findAll() {

        List<AuthUser> users = authUserMapper.findAll();
        users.forEach(
                user -> user.setRoles(
                        authUserMapper.findRolesByUserId(user.getId())
                )
        );
        return users;

    }

    @Override
    public Optional<AuthUser> findByUsername(String username) {

        Optional<AuthUser> user = authUserMapper.findByUsername(username);
        user.ifPresent(u -> u.setRoles(authUserMapper.findRolesByUserId(u.getId())));
        return user;

    }

    @Override
    public Optional<AuthUser> findById(Long userId) {

        Optional<AuthUser> user = authUserMapper.findById(userId);
        user.ifPresent(u -> u.setRoles(authUserMapper.findRolesByUserId(userId)));
        return user;

    }

    @Override
    public Optional<AuthUser> modify(AuthUser user) {

        authUserMapper.update(user);
        return findById(user.getId());

    }

    @Override
    @Transactional
    public AuthUser create(AuthUser user) {

        authUserMapper
                .findByUsername(user.getUsername())
                .ifPresent(u -> {
                    throw new UserAlreadyExistsException(user.getUsername());
                });

        String random = PwdUtil.generate();
        user.setPassword(bcryptEncoder.encode(random));
        user.setPasswordExpiration(Instant.now().plus(appConfiguration.getDefaultPasswordExpiration(), ChronoUnit.DAYS));
        user.setPasswordAttempts(0);

        authUserMapper.insert(user);
        authMapper.grantRole(user.getId(), Constants.ROLE_USER);

        Email email = Email.builder()
                .emailType(EmailType.REMIND_PASSWORD)
                .subject("Your registration")
                .content("Hello " + user.getName() + ", your temporary password is " + random + ".")
                .created(Instant.now())
                .retry(0)
                .recipients(Collections.singletonList(user))
                .build();
        emailService.create(email);

        return user;

    }

    @Override
    public void deleteById(Long userId) {

        authUserMapper.delete(userId);

    }

}
