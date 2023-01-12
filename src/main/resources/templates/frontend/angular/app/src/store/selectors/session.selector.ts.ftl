import { createFeatureSelector, createSelector } from '@ngrx/store';
import { AuthRole, AuthUser } from 'blueprints';
import * as navItems from 'modules/core';
import { MenuItem } from 'primeng/api';
import { translations } from 'store/selectors/ui.selector';
import { SessionState } from 'store/states/session.state';

export const sessionState = createFeatureSelector<SessionState>('session');

export const loggedInUser = createSelector(

	sessionState,
	(session: SessionState): AuthUser | null => session.loggedInUser

);

export const isLoggedIn = createSelector(

	sessionState,
	(session: SessionState): boolean => !!session.loggedInUser

);

export const loggedInUserRoles = createSelector(

	sessionState,
	(session: SessionState): string[] => session.loggedInUser?.roles || []

);

export const loggedInUserToken = createSelector(

	sessionState,
	(session: SessionState): string | undefined => session.token

);

export const rememberMe = createSelector(

	sessionState,
	(session: SessionState): boolean => session.rememberMe

);

export const navMenuItems = createSelector(

	loggedInUserRoles,
	isLoggedIn,
	translations,
	(roles, isLoggedIn, translations): MenuItem[] => {

		const items: Array<MenuItem> = new Array();
		items.push(navItems.miHome(translations));

		if (isLoggedIn)
			items.push(navItems.miWhoIsOnline(translations));
		else
			items.push(navItems.miLogin(translations));

    <#list entities as entity>
		if (roles.includes(AuthRole.${ entity.name.singular.snake.uppercase }_VIEW))
			items.push(navItems.mi${ entity.name.plural.pascal });

    </#list>
		return items;

	}

);

export const navAdminMenuItems = createSelector(

	loggedInUserRoles,
	translations,
	(roles: string[], translations: any): MenuItem[] => {

		const items: Array<MenuItem> = new Array();

		if (roles.includes(AuthRole.AUTH_USER_VIEW))
			items.push(navItems.miAdminUsers(translations));

		if (roles.includes(AuthRole.CONSTANT_MANAGE))
			items.push(navItems.miAdminConstants(translations));

		return items.length ? [
			{
				label: 'Admin',
				expanded: true,
				items: [...items.values()]
			}
		] : [];

	}

);

export const navSessionMenuItems = createSelector(

	loggedInUser,
	translations,
	(loggedInUser: AuthUser | null, translations: any): MenuItem[] => !!loggedInUser ? [navItems.miSession(loggedInUser, translations)] : []

);
