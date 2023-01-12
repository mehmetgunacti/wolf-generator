import { NgModule } from '@angular/core';
import { Route, RouterModule } from '@angular/router';
import { AuthRole } from 'blueprints';
import { AuthorizedGuard } from 'services';
import { ConstantListPageComponent } from './pages/constant-list-page/constant-list-page.component';

const routes: Route[] = [
	{
		path: '',
		component: ConstantListPageComponent,
		canActivate: [AuthorizedGuard],
		data: {
			roles: [
				AuthRole.CONSTANT_MANAGE
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
export class ConstantRoutingModule { }
