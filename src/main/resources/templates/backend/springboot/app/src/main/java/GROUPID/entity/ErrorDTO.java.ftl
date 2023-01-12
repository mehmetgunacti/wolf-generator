package ${ info.groupId }.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
public class ErrorDTO {

    @Getter
    private final String code;

    @Getter
    private final String message;

}
