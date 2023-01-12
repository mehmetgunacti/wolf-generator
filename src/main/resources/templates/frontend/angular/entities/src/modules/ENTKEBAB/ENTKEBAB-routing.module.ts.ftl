import { NgModule } from '@angular/core';
import { Route, RouterModule } from '@angular/router';
import { AuthRole } from 'blueprints';
import { AuthorizedGuard } from 'services';
import { ${ entity.name.singular.pascal }EditPageComponent } from './pages/${ entity.name.singular.kebab }-edit-page/${ entity.name.singular.kebab }-edit-page.component';
import { ${ entity.name.singular.pascal }ListPageComponent } from './pages/${ entity.name.singular.kebab }-list-page/${ entity.name.singular.kebab }-list-page.component';
import { ${ entity.name.singular.pascal }NewPageComponent } from './pages/${ entity.name.singular.kebab }-new-page/${ entity.name.singular.kebab }-new-page.component';
import { ${ entity.name.singular.pascal }OnePageComponent } from './pages/${ entity.name.singular.kebab }-one-page/${ entity.name.singular.kebab }-one-page.component';

const routes: Route[] = [
	{
		path: '',
		component: ${ entity.name.singular.pascal }ListPageComponent,
		canActivate: [AuthorizedGuard],
		data: {
			roles: [
				AuthRole.${ entity.name.singular.snake.uppercase }_VIEW
			]
		}
	},
	{
		path: ':id/edit',
		component: ${ entity.name.singular.pascal }EditPageComponent,
		canActivate: [AuthorizedGuard],
		data: {
			roles: [
				AuthRole.${ entity.name.singular.snake.uppercase }_EDIT
			]
		}
	},
	{
		path: 'new',
		component: ${ entity.name.singular.pascal }NewPageComponent,
		canActivate: [AuthorizedGuard],
		data: {
			roles: [
				AuthRole.${ entity.name.singular.snake.uppercase }_ADD
			]
		}
	},
	{
		path: ':id',
		component: ${ entity.name.singular.pascal }OnePageComponent,
		canActivate: [AuthorizedGuard],
		data: {
			roles: [
				AuthRole.${ entity.name.singular.snake.uppercase }_VIEW
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
export class ${ entity.name.singular.pascal }RoutingModule { }
