import { NgModule } from '@angular/core';
import { Route, RouterModule } from '@angular/router';
import { ChangePasswordPageComponent } from './pages/change-password-page/change-password-page.component';

const routes: Route[] = [
	{
		path: '',
		component: ChangePasswordPageComponent
	}
];

@NgModule({
	imports: [
		RouterModule.forChild(routes)
	],
	exports: [RouterModule]
})
export class ChangePasswordRoutingModule { }
