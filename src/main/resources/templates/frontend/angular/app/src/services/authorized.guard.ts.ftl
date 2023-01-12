import { Injectable } from '@angular/core';
import {
	ActivatedRouteSnapshot,
	CanActivate,
	RouterStateSnapshot
} from '@angular/router';
import { select, Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { map, take } from 'rxjs/operators';
import * as fromStore from 'store';

function isAuthorized(roles: string[], userRoles: string[]): boolean {

	for (let role of roles)
		if (userRoles.includes(role))
			return true;

	return false;

}

@Injectable({
	providedIn: 'root'
})
export class AuthorizedGuard implements CanActivate {

	constructor(
		private store: Store<fromStore.AppState>
	) { }

	canActivate(
		route: ActivatedRouteSnapshot,
		state: RouterStateSnapshot
	): Observable<boolean> {

		return this.store.pipe(

			select(fromStore.loggedInUserRoles),
			map(userRoles => {

				if (isAuthorized(route.data['roles'], userRoles))
					return true;

				this.store.dispatch(fromStore.navigate({ url: '/403', skipLocationChange: true }));
				return false;

			}),
			take(1)

		);

	}

}
