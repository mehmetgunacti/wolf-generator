import { Injectable } from '@angular/core';
import { Actions, concatLatestFrom, createEffect, ofType } from '@ngrx/effects';
import { Store } from '@ngrx/store';
import { InjectableRxStompConfig, RxStompService } from '@stomp/ng2-stompjs';
import { IMessage } from '@stomp/stompjs';
import { BackendUrls } from 'blueprints';
import { environment } from 'environments/environment';
import { Subscription } from 'rxjs';
import { delay, filter, switchMap, tap } from 'rxjs/operators';
import { storeDTO } from 'store/actions/entity.action';
import {
	activateOnline,
	deactivateOnline,
	pingOnline,
	updateLoggedInUser,
	subscribeOnlineList,
	unsubscribeOnlineList,
	subscribeLoggedInUserChanges
} from 'store/actions/session.action';
import * as selectors from 'store/selectors';

const rxStompConfig: InjectableRxStompConfig = {

	// Which server?
	brokerURL: `${r"${environment.backendWSUrl}"}/online`,

	// Headers
	// Typical keys: login, passcode, host
	// connectHeaders: {

	// 	login: 'guest',
	// 	passcode: 'guest',

	// },

	// How often to heartbeat?
	// Interval in milliseconds, set to 0 to disable
	heartbeatIncoming: 10000, // Typical value 0 - disabled
	heartbeatOutgoing: 10000, // Typical value 20000 - every 20 seconds

	// Wait in milliseconds before attempting auto reconnect
	// Set to 0 to disable
	// Typical value 500 (500 milli seconds)
	reconnectDelay: 2000,

	// Will log diagnostics on console
	// It can be quite verbose, not recommended in production
	// Skip this key to stop logging to console
	debug: (msg: string): void => {

		// console.log(new Date(), msg);

	}

};

@Injectable()
export class OnlineEffects {

	private whoIsOnlineSubscription = new Subscription();
	private loggedInUserChangesSubscription = new Subscription();

	private topicWhoIsOnline$ = this.rxStompService.watch({ destination: BackendUrls.TOPIC_WHO_IS_ONLINE().value });

	constructor(
		private actions$: Actions,
		private store: Store,
		private rxStompService: RxStompService,
	) { }

	activateOnline$ = createEffect(

		() => this.actions$.pipe(

			ofType(activateOnline),
			concatLatestFrom(() => this.store.select(selectors.loggedInUser)),
			switchMap(([, loggedInUser]) => {

				const stompConfig: InjectableRxStompConfig = {

					...rxStompConfig,
					connectHeaders: {
						login: loggedInUser?.username || '',
						username: loggedInUser?.username || ''
					}

				}
				this.rxStompService.configure(stompConfig);
				this.rxStompService.activate();
				return [
					pingOnline(),
					subscribeLoggedInUserChanges()
				];

			})

		)

	);

	deactivateOnline$ = createEffect(

		() => this.actions$.pipe(

			ofType(deactivateOnline),
			tap(() => this.whoIsOnlineSubscription.unsubscribe()),
			tap(() => this.loggedInUserChangesSubscription.unsubscribe()),
			tap(() => this.rxStompService.deactivate())

		),
		{ dispatch: false }

	);

	ping$ = createEffect(

		() => this.actions$.pipe(

			ofType(pingOnline),
			filter(() => this.rxStompService.active),
			concatLatestFrom(() => this.store.select(selectors.loggedInUser)),
			filter(([, loggedInUser]) => !!loggedInUser),
			delay(10000),
			switchMap(([, loggedInUser]) => {

				this.rxStompService.publish({

					destination: `/app/queue/ping/${r"${loggedInUser?.id}"}`

				});
				return [pingOnline()];

			})

		)

	);

	subscribeWhosOnline$ = createEffect(

		() => this.actions$.pipe(

			ofType(subscribeOnlineList),
			tap(() =>

				this.whoIsOnlineSubscription =

				this.topicWhoIsOnline$.subscribe(

					(message: IMessage) => this.store.dispatch(
						storeDTO({
							dto: JSON.parse(message.body),
							emptyStore: true
						})
					)

				)

			)

		),
		{ dispatch: false }

	);

	unsubscribeWhosOnline$ = createEffect(

		() => this.actions$.pipe(

			ofType(unsubscribeOnlineList),
			tap(() => this.whoIsOnlineSubscription.unsubscribe())

		),
		{ dispatch: false }

	);

	subscribeLoggedInUserChanges$ = createEffect(

		() => this.actions$.pipe(

			ofType(subscribeLoggedInUserChanges),
			concatLatestFrom(() => this.store.select(selectors.loggedInUser)),
			tap(([, loggedInUser]) =>

				this.loggedInUserChangesSubscription =
				this.rxStompService
					.watch({ destination: BackendUrls.TOPIC_LOGGED_IN_USER_CHANGES(loggedInUser!.id).value })
					.subscribe(

						(message: IMessage) => this.store.dispatch(
							updateLoggedInUser({ dto: JSON.parse(message.body) })
						)

					)

			)

		),
		{ dispatch: false }

	);

}
