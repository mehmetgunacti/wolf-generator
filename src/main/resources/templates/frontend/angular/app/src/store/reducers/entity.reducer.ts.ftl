import { Action, ActionReducer, createReducer, on } from '@ngrx/store';
import { BaseDTO, ID } from 'blueprints';
import produce from 'immer';
import { activateEntity, deactivateEntity, storeDTO } from 'store/actions/entity.action';
import { ActiveEntity, EntitiesState, initialEntitiesState } from 'store/states/entity.state';

const setAll = (draft: EntitiesState, dto: BaseDTO, emptyStore: boolean = false): void => {

	Object.keys(dto.data).forEach((entityName: string) => {


		// Do not use initialEntityState here or an "'entities[8]' is not extensible" error will occur
		// => you'd have to deep init anyway
		if (emptyStore)
			draft.data[entityName] = { entities: {}, ids: [], initialized: false };

		// assign incoming entities
		// to tell frontend that an entity was deleted,
		// backend sends the id inside the ids array but
		// does not include an entity (obviously) in the entities array.
		// So, if dto.ids has a value but dto.entities[id] not => value was deleted on server
		// This 'if' statement below is only here so that Http.DELETE operations work.
		dto.data[entityName].ids.forEach((id: ID) => {

			const entity = dto.data[entityName].entities[id];
			if (!!entity)
				draft.data[entityName].entities[id] = entity;
			else
				delete draft.data[entityName].entities[id];

		});

		// re-calculate ids array
		draft.data[entityName].ids = Object.keys(
			draft.data[entityName].entities
		);


		// only a re-init of the store will set 'initialized' back to false
		draft.data[entityName].initialized = true;

	});

};

const setActiveEntity = (draft: EntitiesState, activeEntity: ActiveEntity): void => {

	// also deletes the property if empty
	// e.g. if 'id' is undefined 'active's property
	// will be set to undefined, hence removed
	const { entityName, id } = activeEntity;
	draft.active = { entityName, id };

};

export const entitiesReducer: ActionReducer<EntitiesState, Action> = createReducer(

	initialEntitiesState,
	on(storeDTO, (state, params) => {

		return produce(state, draft => setAll(draft, params['dto'], params['emptyStore']));

	}),
	on(activateEntity, (state, activeEntity) => {

		return produce(state, draft => setActiveEntity(draft, activeEntity));

	}),
	on(deactivateEntity, state => {

		return produce(state, draft => { draft.active = {} });

	})


);
