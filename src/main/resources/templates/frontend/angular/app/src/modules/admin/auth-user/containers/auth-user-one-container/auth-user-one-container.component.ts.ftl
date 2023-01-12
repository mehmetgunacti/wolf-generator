import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { AuthUser, Entities, ID } from 'blueprints';
import { AuthRole } from 'blueprints';
import { ConfirmationService } from 'primeng/api';
import { Observable } from 'rxjs';
import * as actions from 'store';
import * as selectors from 'store';

@Component({
	selector: 'app-auth-user-one-container',
	templateUrl: './auth-user-one-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class AuthUserOneContainerComponent {

	AuthRole = AuthRole;

	user$: Observable<AuthUser>;

	constructor(
		private store: Store,
		private confirmationService: ConfirmationService
	) {

		this.user$ = store.select(selectors.activeEntity);

	}

	onRefresh(id: ID): void {

		this.store.dispatch(
			actions.loadEntity({ entity: Entities.authUsers, id, skipCache: true })
		);

	}

	onDelete(id: ID, btn: HTMLButtonElement): void {

		this.confirmationService.confirm({
			target: btn,
			message: 'Are you sure that you want to proceed?',
			icon: 'fas fa-exclamation-triangle',
			acceptButtonStyleClass: 'p-button-danger',
			acceptLabel: 'Delete',
			accept: () => this.store.dispatch(actions.deleteEntity({ entity: Entities.authUsers, id }))
		});

	}

	onDisableAccount(id: ID): void {

		this.store.dispatch(actions.disableAccount({ id }));

	}

	onEnableAccount(id: ID): void {

		this.store.dispatch(actions.enableAccount({ id }));

	}

	onRole(role: AuthRole, id: ID): void {

		this.store.dispatch(actions.toggleRole({ id, role }));

	}

}
