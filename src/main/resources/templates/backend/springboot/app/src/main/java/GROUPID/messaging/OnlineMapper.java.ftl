package ${ info.groupId }.messaging;

import ${ info.groupId }.entity.user.User;
import org.apache.ibatis.annotations.Mapper;

import java.time.Instant;
import java.util.List;
import java.util.Set;

@Mapper
interface OnlineMapper {

    boolean isOnline(Long id);

    void add(Long id, Instant lastPing);

    int ping(Long id, Instant lastPing);

    void remove(Long id);

    List<User> findAll(Set<Long> ids);

}
