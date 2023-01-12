import { createSelector } from '@ngrx/store';
import { Constant, Entities } from 'blueprints';
import { EntitiesState } from 'store/states/entity.state';
import { UIState } from 'store/states/ui.state';
import { entitiesState } from './entity.selector';
import { uiState } from './ui.selector';

export const constantAll = createSelector(

	entitiesState,
	(state: EntitiesState) => Object.values(state.data[Entities.constants.plural].entities)

);

export const constantCategoriesAll = createSelector(

	constantAll,
	(constants: Constant[]) => [... new Set(constants.map(c => c.category))]

);

export const constantSelectedCategory = createSelector(

	uiState,
	(state: UIState) => state.constant.selectedCategory

);

export const constantFilteredBySelectedCategory = createSelector(

	constantAll,
	constantSelectedCategory,
	(constants, selectedCategory) => {

		return constants.filter(constant => constant.category === selectedCategory);

	}

);
