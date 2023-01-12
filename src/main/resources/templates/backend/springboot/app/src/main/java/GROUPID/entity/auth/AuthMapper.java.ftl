package ${ info.groupId }.entity.auth;

import ${ info.groupId }.service.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.Instant;

@Mapper
public interface AuthMapper extends BaseMapper<AuthUser, Long> {

    void grantRole(@Param("userId") Long userId, @Param("role") String role);

    void revokeRole(@Param("userId") Long userId, @Param("role") String role);

    void remindPassword(AuthUser user);

    void changePassword(
            @Param("username") String username,
            @Param("password") String password,
            @Param("passwordExpiration") Instant passwordExpiration
    );

    void disableAccount(@Param("userId") Long userId);

}
