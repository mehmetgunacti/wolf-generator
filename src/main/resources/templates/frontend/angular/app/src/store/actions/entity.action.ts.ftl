import { createAction, props } from '@ngrx/store';
import { BaseDTO, Entity, EntityType, ID } from 'blueprints';
import { ActiveEntity } from 'store/states/entity.state';

export const createEntity = createAction(
	'[Entity] Create Entity',
	props<{
		entity: Entity,
		body: EntityType,
		after: {
			redirect: boolean,
			showSuccess: boolean
		}
	}>()
);

export const modifyEntity = createAction(
	'[Entity] Modify Entity',
	props<{
		entity: Entity,
		id: ID,
		body: Partial<EntityType>,
		after: {
			redirect: boolean,
			showSuccess: boolean
		}
	}>()
);

export const deleteEntity = createAction(
	'[Entity] Delete Entity',
	props<{
		entity: Entity,
		id: ID
	}>()
);

export const loadEntity = createAction(
	'[Entity] Load Entity',
	props<{
		entity: Entity,
		id: ID,
		skipCache?: boolean
	}>()
);

export const loadEntities = createAction(
	'[Entity] Load Entities',
	props<{
		entity: Entity,
		skipCache?: boolean
	}>()
);

export const storeDTO = createAction(
	'[Entity] Store DTO',
	props<{
		dto: BaseDTO,
		emptyStore?: boolean
	}>()
);

export const activateEntity = createAction(
	'[Entity] Activate Entity',
	props<ActiveEntity>()
);

export const deactivateEntity = createAction(
	'[Entity] Deactivate Entity',
	props<{ key: string }>()
);
