package ${ info.groupId }.entity.auth;

import ${ info.groupId }.service.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Mapper
public interface AuthUserMapper extends BaseMapper<AuthUser, Long> {

    List<AuthUser> findAll();

    Optional<AuthUser> findById(Long id);

    Optional<AuthUser> findByUsername(String username);

    Set<String> findRolesByUserId(Long userId);

    List<AuthUser> findByRole();

    void insert(AuthUser user);

    void update(AuthUser user);

    void delete(Long id);

}
