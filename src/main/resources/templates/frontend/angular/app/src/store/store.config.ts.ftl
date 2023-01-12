import { Action, ActionReducer, ActionReducerMap, MetaReducer } from '@ngrx/store';
import * as fromEffects from 'store/effects';
import * as fromReducers from 'store/reducers';
import * as fromStates from 'store/states';
import * as fromActions from 'store/actions';

export function clearState(reducer: ActionReducer<fromStates.AppState>): ActionReducer<fromStates.AppState> {

	return function (state: fromStates.AppState | undefined, action: Action) {

		if (action.type === fromActions.logout.type) {
			state = {
				...fromStates.initialAppState,
				ui: state?.ui || fromStates.initialUIState
			};
			localStorage.removeItem('token');
		}
		return reducer(state, action);

	};

}

export const metaReducers: MetaReducer<fromStates.AppState>[] = [

	clearState

];

export const effects = [

	fromEffects.EntityEffects,
	fromEffects.NotificationEffects,
	fromEffects.NavigationEffects,
	fromEffects.SessionEffects,
	fromEffects.OnlineEffects,
	fromEffects.UIEffects

];

export const reducers: ActionReducerMap<fromStates.AppState> = {

	entities: fromReducers.entitiesReducer,
	session: fromReducers.sessionReducer,
	ui: fromReducers.uiReducer

};
