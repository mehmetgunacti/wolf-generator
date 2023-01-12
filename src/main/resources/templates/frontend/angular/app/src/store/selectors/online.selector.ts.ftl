import { createSelector } from '@ngrx/store';
import { Entities, User } from 'blueprints';
import { EntitiesState } from 'store/states/entity.state';
import { entitiesState } from './entity.selector';

export const onlineUsersAll = createSelector(

	entitiesState,
	(state: EntitiesState): User[] => Object.values(state.data[Entities.onlineUsers.plural].entities)

);
