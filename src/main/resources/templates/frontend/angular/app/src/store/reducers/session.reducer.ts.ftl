import { Action, ActionReducer, createReducer, on } from '@ngrx/store';
import { AuthUser } from 'blueprints';
import produce from 'immer';
import { updateLoggedInUser, loginSuccess, toggleToken } from 'store/actions/session.action';
import { initialSessionState, SessionState } from 'store/states/session.state';

export const sessionReducer: ActionReducer<SessionState, Action> = createReducer(

	initialSessionState,
	on(loginSuccess, (state, { dto }) => {

		const loggedInUser: AuthUser = dto.data['authUsers'].entities[dto.data['authUsers'].ids[0]];

		// when logging in via LoginForm && rememberMe is checked
		if (state.rememberMe)
			localStorage.setItem('token', dto.token || '');

		return produce(state, draft => {
			draft.loggedInUser = loggedInUser;
			draft.token = dto.token;
		});

	}),
	// when loggedInUser data is sent via websocket
	on(updateLoggedInUser, (state, { dto }) => {

		const loggedInUser: AuthUser = dto.data['authUsers'].entities[dto.data['authUsers'].ids[0]];

		return produce(state, draft => {
			draft.loggedInUser = loggedInUser;
		});

	}),
	on(toggleToken, (state, { rememberMe }) => produce(state, draft => { draft.rememberMe = rememberMe }))

);
