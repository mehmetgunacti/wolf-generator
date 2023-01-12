import { ChangeDetectionStrategy, Component, Input } from '@angular/core';
import { AuthUser } from 'blueprints';

@Component({
	selector: 'app-auth-user-password',
	templateUrl: './auth-user-password.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class AuthUserPasswordComponent {

	@Input() user: AuthUser | undefined | null;

}
