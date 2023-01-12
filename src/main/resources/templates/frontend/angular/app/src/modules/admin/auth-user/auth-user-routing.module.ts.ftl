import { NgModule } from '@angular/core';
import { Route, RouterModule } from '@angular/router';
import { AuthRole } from 'blueprints';
import { AuthorizedGuard } from 'services';
import { AuthUserEditPageComponent } from './pages/auth-user-edit-page/auth-user-edit-page.component';
import { AuthUserListPageComponent } from './pages/auth-user-list-page/auth-user-list-page.component';
import { AuthUserNewPageComponent } from './pages/auth-user-new-page/auth-user-new-page.component';
import { AuthUserOnePageComponent } from './pages/auth-user-one-page/auth-user-one-page.component';

const routes: Route[] = [
	{
		path: '',
		component: AuthUserListPageComponent,
		canActivate: [AuthorizedGuard],
		data: {
			roles: [
				AuthRole.AUTH_USER_VIEW
			]
		}
	},
	{
		path: ':id/edit',
		component: AuthUserEditPageComponent,
		canActivate: [AuthorizedGuard],
		data: {
			roles: [
				AuthRole.AUTH_USER_EDIT
			]
		}
	},
	{
		path: 'new',
		component: AuthUserNewPageComponent,
		canActivate: [AuthorizedGuard],
		data: {
			roles: [
				AuthRole.AUTH_USER_EDIT
			]
		}
	},
	{
		path: ':id',
		component: AuthUserOnePageComponent,
		canActivate: [AuthorizedGuard],
		data: {
			roles: [
				AuthRole.AUTH_USER_VIEW
			]
		}
	}
];

@NgModule({
	imports: [
		RouterModule.forChild(routes)
	],
	exports: [RouterModule]
})
export class AuthUserRoutingModule { }
