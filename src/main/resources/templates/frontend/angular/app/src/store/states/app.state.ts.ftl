import { EntitiesState, initialEntitiesState } from './entity.state';
import { SessionState, initialSessionState } from './session.state';
import { UIState, initialUIState } from './ui.state';

export interface AppState {

	entities: EntitiesState;
	session: SessionState;
	ui: UIState;

}

export const initialAppState: AppState = {

	entities: initialEntitiesState,
	session: initialSessionState,
	ui: initialUIState

};
