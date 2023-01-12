import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { AuthUser } from 'blueprints';
import { ChangePasswordDTO } from 'blueprints/dto/change-password.dto';
import { Observable } from 'rxjs';
import * as actions from 'store';
import * as selectors from 'store';

@Component({
	selector: 'app-change-password-container',
	templateUrl: './change-password-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ChangePasswordContainerComponent {

	loggedInUser$: Observable<AuthUser | null>;

	constructor(private store: Store) {

		this.loggedInUser$ = store.select(selectors.loggedInUser);

	}

	onChangePassword(dto: ChangePasswordDTO): void {

		this.store.dispatch(actions.changePassword({ dto }));

	}

}
