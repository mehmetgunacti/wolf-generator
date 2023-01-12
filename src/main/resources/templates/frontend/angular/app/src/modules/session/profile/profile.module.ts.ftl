import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from 'modules/shared/shared.module';
import { ProfileRoutingModule } from './profile-routing.module';
import * as fromConfig from './profile.config';

@NgModule({
	declarations: fromConfig.components,
	imports: [
		CommonModule,
		ProfileRoutingModule,
		ReactiveFormsModule,
		SharedModule
	]
})
export class ProfileModule { }
