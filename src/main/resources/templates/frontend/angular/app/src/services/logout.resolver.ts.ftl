import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, Resolve, RouterStateSnapshot } from '@angular/router';
import { Store } from '@ngrx/store';
import * as actions from 'store/actions';

@Injectable({
	providedIn: 'root'
})
export class LogoutResolver implements Resolve<void> {

	constructor(private store: Store) { }

	resolve(
		route: ActivatedRouteSnapshot,
		state: RouterStateSnapshot
	): void {

		this.store.dispatch(actions.logout());

	}

}
