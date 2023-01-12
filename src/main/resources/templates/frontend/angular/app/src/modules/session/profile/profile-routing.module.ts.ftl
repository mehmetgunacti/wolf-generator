import { NgModule } from '@angular/core';
import { Route, RouterModule } from '@angular/router';
import { ProfilePageComponent } from './pages/profile-page/profile-page.component';

const routes: Route[] = [
	{
		path: '',
		component: ProfilePageComponent
	}
];

@NgModule({
	imports: [
		RouterModule.forChild(routes)
	],
	exports: [RouterModule]
})
export class ProfileRoutingModule { }
