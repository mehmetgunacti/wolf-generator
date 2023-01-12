import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { AuthUser, Entities } from 'blueprints';
import * as actions from 'store';

@Component({
	selector: 'app-auth-user-new-container',
	templateUrl: './auth-user-new-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class AuthUserNewContainerComponent {

	constructor(
		private store: Store
	) {	}

	onSave(user: AuthUser): void {

		this.store.dispatch(
			actions.createEntity({
				entity: Entities.authUsers,
				body: user,
				after: { redirect: true, showSuccess: true }
			})
		);

	}

}
