import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from 'modules/shared/shared.module';
import { ${ entity.name.singular.pascal }RoutingModule } from './${ entity.name.singular.kebab }-routing.module';
import * as fromConfig from './${ entity.name.singular.kebab }.config';

@NgModule({
	declarations: fromConfig.components,
	imports: [
		CommonModule,
		${ entity.name.singular.pascal }RoutingModule,
		ReactiveFormsModule,
		SharedModule
	]
})
export class ${ entity.name.singular.pascal }Module { }
