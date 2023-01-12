import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { AuthUser, Entities } from 'blueprints';
import { Observable } from 'rxjs';
import * as actions from 'store';
import * as selectors from 'store';

@Component({
	selector: 'app-auth-user-edit-container',
	templateUrl: './auth-user-edit-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class AuthUserEditContainerComponent {

	user$: Observable<AuthUser>;

	constructor(
		private store: Store
	) {

		this.user$ = store.select(selectors.activeEntity);

	}

	onSave(user: AuthUser): void {

		this.store.dispatch(
			actions.modifyEntity({
				entity: Entities.authUsers,
				id: user.id,
				body: user,
				after: { redirect: true, showSuccess: true }
			})
		);

	}

}
