import { ChangeDetectionStrategy, Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Store } from '@ngrx/store';
import { Entities } from 'blueprints';
import { Subscription } from 'rxjs';
import * as actions from 'store';

@Component({
	selector: 'app-auth-user-one-page',
	templateUrl: './auth-user-one-page.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class AuthUserOnePageComponent implements OnInit, OnDestroy {

	subscription = new Subscription();

	constructor(
		private route: ActivatedRoute,
		private store: Store
	) { }

	ngOnInit(): void {

		this.subscription.add(

			this.route.params.subscribe(params =>
				this.store.dispatch(
					actions.activateEntity({
						entityName: Entities.authUsers.plural,
						id: params['id']
					})
				)
			)

		);

	}

	ngOnDestroy(): void {

		this.subscription.unsubscribe();

	}

}
