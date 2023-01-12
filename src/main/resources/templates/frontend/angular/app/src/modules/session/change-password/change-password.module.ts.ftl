import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from 'modules/shared/shared.module';
import { ChangePasswordRoutingModule } from './change-password-routing.module';
import * as fromConfig from './change-password.config';

@NgModule({
	declarations: fromConfig.components,
	imports: [
		CommonModule,
		ChangePasswordRoutingModule,
		ReactiveFormsModule,
		SharedModule
	]
})
export class ChangePasswordModule { }
