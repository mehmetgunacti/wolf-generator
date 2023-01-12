package ${ info.groupId }.constant;

import lombok.Getter;

@Getter
public enum EmailType {

    REMIND_PASSWORD(1),
    CHANGE_PASSWORD(2);

    private Integer id;

    EmailType(Integer id) {

        this.id = id;

    }

}
