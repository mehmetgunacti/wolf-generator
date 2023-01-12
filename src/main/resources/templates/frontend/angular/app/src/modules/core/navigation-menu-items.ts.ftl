import { AuthUser } from 'blueprints';
import { MenuItem } from 'primeng/api';

export const miProfile = (tx: any): MenuItem => ({
	label: tx['profile'],
	icon: 'fas fa-fw fa-user-circle',
	routerLink: ['/profile']
});

export const miChangePassword = (tx: any): MenuItem => ({
	label: tx['changePassword'],
	icon: 'fas fa-fw fa-key',
	routerLink: ['/change-password']
});

export const miLogout = (tx: any): MenuItem => ({
	label: tx['logout'],
	icon: 'fas fa-fw fa-sign-out-alt',
	routerLink: ['/logout']
});

export const miLogin = (tx: any): MenuItem => ({
	label: tx['login'],
	icon: 'fas fa-fw fa-sign-in-alt',
	routerLink: ['/login']
});

export const miAdminUsers = (tx: any): MenuItem => ({
	label: tx['users'],
	icon: 'fas fa-fw fa-users',
	routerLink: ['/admin/users']
});

export const miAdminConstants = (tx: any): MenuItem => ({
	label: tx['constants'],
	icon: 'fas fa-fw fa-list',
	routerLink: ['/admin/constants']
});

export const miHome = (tx: any): MenuItem => ({
	label: tx['home'],
	icon: 'fas fa-fw fa-home',
	routerLink: [''],
	routerLinkActiveOptions: { exact: true }
});

export const miWhoIsOnline = (tx: any): MenuItem => ({
	label: tx['onlineUsers'],
	icon: 'fas fa-fw fa-globe-europe',
	routerLink: ['/online'],
	routerLinkActiveOptions: { exact: true }
});

<#list entities as entity>
export const mi${ entity.name.plural.pascal }: MenuItem = {
	label: '${ entity.name.plural.pascal }',
	icon: 'fas fa-fw fa-bookmark',
	routerLink: ['/${ entity.name.plural.kebab }']
};
</#list>

export const miSession = (loggedInUser: AuthUser | null, tx: any): MenuItem => ({
	label: !!loggedInUser ? `${r"${loggedInUser.name}"} (${r"${loggedInUser.username}"})` : 'Session',
	expanded: true,
	items: [
		miProfile(tx),
		miChangePassword(tx),
		miLogout(tx)
	]
});