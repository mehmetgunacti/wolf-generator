import { ChangeDetectionStrategy, Component, EventEmitter, Input, Output } from '@angular/core';
import { AuthRole } from 'blueprints';

@Component({
	selector: 'app-auth-user-auth-form',
	templateUrl: './auth-user-auth-form.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class AuthUserAuthFormComponent {

	Role = AuthRole;

	@Input() userRoles: string[] = [];
	@Output() role = new EventEmitter<AuthRole>();

	onRole(role: AuthRole): void {

		this.role.emit(role);

	}

}
