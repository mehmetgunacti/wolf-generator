import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from 'modules/shared/shared.module';
import { AuthUserRoutingModule } from './auth-user-routing.module';
import * as fromConfig from './auth-user.config';

@NgModule({
	declarations: fromConfig.components,
	imports: [
		CommonModule,
		AuthUserRoutingModule,
		ReactiveFormsModule,
		SharedModule
	]
})
export class AuthUserModule { }
