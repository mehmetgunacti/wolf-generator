import { ChangeDetectionStrategy, Component, OnInit } from '@angular/core';
import { Store } from '@ngrx/store';
import { AuthRole, Entities, User } from 'blueprints';
import { Observable } from 'rxjs';
import * as actions from 'store';
import * as selectors from 'store';

@Component({
	selector: 'app-auth-user-list-container',
	templateUrl: './auth-user-list-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class AuthUserListContainerComponent implements OnInit {

	AuthRole = AuthRole;

	users$: Observable<User[]>;

	constructor(
		private store: Store
	) {

		this.users$ = store.select(selectors.activeEntities);

	}

	ngOnInit(): void {

		this.store.dispatch(
			actions.loadEntities({
				entity: Entities.authUsers
			})
		);

	}

	onRefresh(): void {

		this.store.dispatch(
			actions.loadEntities({
				entity: Entities.authUsers,
				skipCache: true
			})
		);

	}

}
