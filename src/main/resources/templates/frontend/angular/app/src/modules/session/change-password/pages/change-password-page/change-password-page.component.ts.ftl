import { ChangeDetectionStrategy, Component } from '@angular/core';

@Component({
	selector: 'app-change-password-page',
	templateUrl: './change-password-page.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ChangePasswordPageComponent { }
