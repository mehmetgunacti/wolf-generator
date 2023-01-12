import { BackendUrl, backendUrl, ID } from 'blueprints';
import * as fromEntities from 'blueprints/entity';

export class Entity {

	constructor(
		public name: string,
		public plural: string = name,
		public customEndpoint: string = plural,
		public customRoute: string = plural
	) { }

	public endpointUrl(id?: ID): BackendUrl {

		return ({ value: `${r"${backendUrl}"}/${r"${this.customEndpoint}"}${r"${id ? '/' + id : ''}"}` });

	}

	public routeUrl(id?: ID): string {

		return `/${r"${this.customRoute}"}${r"${id ? '/' + id : ''}"}`;

	}

}

interface IEntities {

	authUsers: Entity;
	constants: Entity;
	<#list entities as entity>
	${ entity.name.plural }: Entity;
	</#list>
	onlineUsers: Entity;

}

export declare type EntityType =
    <#list entities as entity>
	fromEntities.${ entity.name.singular.pascal } |
	</#list>
	fromEntities.AuthUser |
	fromEntities.Constant;

export const Entities: IEntities = {

	authUsers: new Entity('authUser', 'authUsers', 'auth/users', 'admin/users'),
	constants: new Entity('constant', 'constants', 'auth/constants', 'admin/constants'),
	<#list entities as entity>
	${ entity.name.plural }: new Entity('${ entity.name.singular }', '${ entity.name.plural }', '${ entity.name.plural.kebab }', '${ entity.name.plural.kebab }'),
	</#list>
	onlineUsers: new Entity('onlineUser', 'onlineUsers')

}
