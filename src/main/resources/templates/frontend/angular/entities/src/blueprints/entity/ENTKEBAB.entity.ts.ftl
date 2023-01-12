import { BaseEntity } from './base-entity';
import { ID } from 'blueprints/constant';

export interface ${ entity.name.singular.pascal } extends BaseEntity {

<#list entity.fields as field>
	${ field.name }: ${ field.typescript };
</#list>

}

// export interface ${ entity.name.singular.pascal }DTO {
// 
// 	entities: {
// 		${ entity.name.plural }: Record<string, ${ entity.name.singular.pascal }>;
// 	};
// 	result: ID[];
// 
// }
