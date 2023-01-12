import { BaseEntity, ID } from 'blueprints';

export interface ActiveEntity {

	entityName?: string;
	id?: ID;

}

export interface EntityState<T extends BaseEntity> {

	ids: ID[];
	entities: Record<ID, T>;
	initialized: boolean;

}

const initialEntityState: EntityState<any> = {

	ids: [],
	entities: {},
	initialized: false

};

export interface EntitiesState {

	data: Record<string, EntityState<any>>;
	active: ActiveEntity;

}

export const initialEntitiesState: EntitiesState = {

	data: {
		authUsers: { ...initialEntityState },
		onlineUsers: { ...initialEntityState },
		constants: { ...initialEntityState },
	<#list entities as entity>
		${ entity.name.plural }: { ...initialEntityState }<#sep>,</#sep>
	</#list>
	},
	active: {}

};
