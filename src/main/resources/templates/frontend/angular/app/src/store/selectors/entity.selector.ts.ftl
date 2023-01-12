import { createFeatureSelector, createSelector } from '@ngrx/store';
import { AppState } from 'store/states/app.state';
import { EntitiesState } from 'store/states/entity.state';

export const appState = (state: AppState) => state;
export const entitiesState = createFeatureSelector<EntitiesState>('entities');

export const activeEntityInfo = createSelector(

	entitiesState,
	(entities: EntitiesState) => entities.active

);

export const activeEntity = createSelector(

	entitiesState,
	activeEntityInfo,
	(entities, activeEntity) => {

		const { entityName, id } = activeEntity;
		if (entityName && id)
			return entities.data[entityName].entities[id];

		return null;

	}

);

export const activeEntities = createSelector(

	entitiesState,
	activeEntityInfo,
	(entities, activeEntity) => {

		const { entityName } = activeEntity;
		if (entityName)
			return Object.values(entities.data[entityName].entities);

		return [];

	}

);

export const activeEntitiesInitialized = createSelector(

	entitiesState,
	activeEntityInfo,
	(entities, activeEntity): boolean => {

		const { entityName } = activeEntity;
		return !!entityName && entities.data[entityName].initialized;

	}

);

