import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, RouterStateSnapshot } from '@angular/router';
import { select, Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { map, take } from 'rxjs/operators';
import * as fromStore from 'store';

@Injectable({
	providedIn: 'root'
})
export class AuthenticatedGuard implements CanActivate {

	constructor(
		private store: Store<fromStore.AppState>
	) { }

	canActivate(
		route: ActivatedRouteSnapshot,
		state: RouterStateSnapshot
	): Observable<boolean> {

		return this.store.pipe(

			select(fromStore.isLoggedIn),
			map(isLoggedIn => {

				if (isLoggedIn)
					return true;

				this.store.dispatch(fromStore.navigate({ url: '/403', skipLocationChange: true }));
				return false;

			}),
			take(1)

		);

	}

}
