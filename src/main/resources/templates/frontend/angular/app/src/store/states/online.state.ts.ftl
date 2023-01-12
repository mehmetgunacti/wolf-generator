import { User } from 'blueprints';

export interface OnlineState {

	users: User[];

}

export const initialOnlineState: OnlineState = {

	users: []

};
