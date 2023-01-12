import { Component, OnDestroy, OnInit } from '@angular/core';
import { Store } from '@ngrx/store';
import { User } from 'blueprints';
import { Observable } from 'rxjs';
import { onlineUsersAll, subscribeOnlineList, unsubscribeOnlineList } from 'store';

@Component({
	selector: 'app-online-page',
	templateUrl: './online-page.component.html'
})
export class OnlinePageComponent implements OnInit, OnDestroy {

	onlineUsers$: Observable<User[]>;

	constructor(private store: Store) {

		this.onlineUsers$ = store.select(onlineUsersAll);

	}

	ngOnInit(): void {

		this.store.dispatch(subscribeOnlineList());

	}

	ngOnDestroy(): void {

		this.store.dispatch(unsubscribeOnlineList());

	}

}
