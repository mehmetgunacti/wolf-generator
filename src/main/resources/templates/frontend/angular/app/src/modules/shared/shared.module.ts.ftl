import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { PrimeNgModule } from 'modules/primeng.module';
import { PortalComponent, UserInfoComponent } from './components';
import { HasRoleDirective } from './directives';

@NgModule({
	declarations: [
		PortalComponent,
		UserInfoComponent,
		HasRoleDirective
	],
	imports: [
		CommonModule,
		RouterModule,
		PrimeNgModule
	],
	exports: [
		PrimeNgModule,
		PortalComponent,
		UserInfoComponent,
		HasRoleDirective,
		TranslateModule
	],
	providers: []
})
export class SharedModule { }
