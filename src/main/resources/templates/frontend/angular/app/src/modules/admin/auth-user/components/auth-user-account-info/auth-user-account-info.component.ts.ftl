import { ChangeDetectionStrategy, Component, EventEmitter, Input, Output } from '@angular/core';
import { AuthRole, AuthUser, ID } from 'blueprints';

@Component({
	selector: 'app-auth-user-account-info',
	templateUrl: './auth-user-account-info.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class AuthUserAccountInfoComponent {

	AuthRole = AuthRole;

	@Input() user: AuthUser | undefined | null;

	@Output() enableAccount = new EventEmitter<ID>();
	@Output() disableAccount = new EventEmitter<ID>();

	toggleAccount(): void {

		if (this.user)
			if (this.user.accountEnabled)
				this.disableAccount.emit(this.user.id);
			else
				this.enableAccount.emit(this.user.id);

	}

}
