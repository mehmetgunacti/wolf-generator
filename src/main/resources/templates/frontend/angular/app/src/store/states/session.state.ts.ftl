import { AuthUser } from 'blueprints';

export interface SessionState {

	loggedInUser: AuthUser | null;
	token?: string;
	rememberMe: boolean;

}

export const initialSessionState: SessionState = {

	loggedInUser: null,
	rememberMe: false

};
