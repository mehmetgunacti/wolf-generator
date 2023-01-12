package ${ info.groupId }.entity.auth;

import ${ info.groupId }.service.EntityService;

import java.util.Optional;

public interface AuthUserService extends EntityService<AuthUser, Long> {

    Optional<AuthUser> findByUsername(String username);

}
