package ${ info.groupId }.entity.${ entity.name.singular };

import ${ info.groupId }.entity.BaseEntity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ${ entity.name.singular.pascal } extends BaseEntity {

	<#list entity.fields as field>
	protected ${ field.java } ${ field.name };
	</#list>

}
