import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from 'modules/shared/shared.module';
import { ConstantRoutingModule } from './constant-routing.module';
import * as fromConfig from './constant.config';

@NgModule({
	declarations: fromConfig.components,
	imports: [
		CommonModule,
		ConstantRoutingModule,
		FormsModule,
		ReactiveFormsModule,
		SharedModule
	]
})
export class ConstantModule { }
