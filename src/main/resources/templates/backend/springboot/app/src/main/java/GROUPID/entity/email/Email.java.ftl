package ${ info.groupId }.entity.email;

import ${ info.groupId }.constant.EmailType;
import ${ info.groupId }.entity.BaseEntity;
import ${ info.groupId }.entity.constant.Constant;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
@ToString
public class Email extends BaseEntity {

    protected EmailType emailType;
    protected String    subject;
    protected String    content;
    protected Integer   retry;

    protected List<BaseEntity> recipients;
    protected List<Long>       attachments;

}
