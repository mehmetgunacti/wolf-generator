package ${ info.groupId }.entity.auth;

import ${ info.groupId }.constant.EntityNames;
import ${ info.groupId }.entity.BaseDTO;
import ${ info.groupId }.entity.user.User;
import lombok.Getter;
import lombok.Setter;

import java.util.Collections;
import java.util.List;
import java.util.Map;

public class AuthUserDTO extends BaseDTO {

    @Getter
    @Setter
    private String token;

    public AuthUserDTO(List<? extends User> entities) {

        super(
                Map.of(
                        EntityNames.authUsers, new EntityDTO(entities)
                )
        );

    }

    public AuthUserDTO(AuthUser user) {

        this(Collections.singletonList(user));

    }

    public AuthUserDTO(Long id) {

        super(
                Map.of(
                        EntityNames.authUsers, new EntityDTO(id)
                )
        );

    }

}
