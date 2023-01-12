package ${ info.groupId }.entity.user;

import ${ info.groupId }.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDate;

@Slf4j
@Getter
@Setter
@ToString
public class User extends BaseEntity {

    protected String    name;
    protected String    username;
    protected String    title;
    protected LocalDate birthdate;
    protected String    mobile;
    protected String    phone;

}