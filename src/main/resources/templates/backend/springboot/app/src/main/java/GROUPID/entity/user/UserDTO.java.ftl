package ${ info.groupId }.entity.user;

import ${ info.groupId }.constant.EntityNames;
import ${ info.groupId }.entity.BaseDTO;

import java.util.Collections;
import java.util.List;
import java.util.Map;

public class UserDTO extends BaseDTO {

    public UserDTO(List<User> entities) {

        super(
                Map.of(
                        EntityNames.onlineUsers, new EntityDTO(entities)
                )
        );

    }

    public UserDTO(User onlineUser) {

        this(Collections.singletonList(onlineUser));

    }

    // constructor for empty DTO == EntityNotFoundException
    public UserDTO(Long id) {

        super(
                Map.of(
                        EntityNames.onlineUsers, new EntityDTO(id)
                )
        );

    }

}
