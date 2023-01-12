import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { AuthUser } from 'blueprints';
import { Observable } from 'rxjs';
import * as selectors from 'store';

@Component({
	selector: 'app-profile-page',
	templateUrl: './profile-page.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ProfilePageComponent {

	user$: Observable<AuthUser | null>;

	constructor(private store: Store) {

		this.user$ = this.store.select(selectors.loggedInUser);

	}

}
