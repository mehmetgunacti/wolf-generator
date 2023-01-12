import { NgModule } from '@angular/core';
import { Route, RouterModule } from '@angular/router';
import { AuthenticatedGuard, LogoutResolver } from 'services';
import { HomePageComponent } from './pages/home-page/home-page.component';
import { LoginPageComponent } from './pages/login-page/login-page.component';
import { OnlinePageComponent } from './pages/online-page/online-page.component';
import { RegisterPageComponent } from './pages/register-page/register-page.component';
import { RemindPasswordPageComponent } from './pages/remind-password-page/remind-password-page.component';

const routes: Route[] = [
	{
		path: '',
		component: HomePageComponent
	},
	{
		path: 'login',
		component: LoginPageComponent
	},
	{
		path: 'online',
		component: OnlinePageComponent,
		canActivate: [AuthenticatedGuard]
	},
	{
		path: 'remind-password',
		component: RemindPasswordPageComponent
	},
	{
		path: 'register',
		component: RegisterPageComponent
	},
	{
		path: 'logout',
		resolve: [LogoutResolver]
	}
];

@NgModule({
	imports: [
		RouterModule.forChild(routes)
	],
	exports: [RouterModule]
})
export class HomeRoutingModule { }
