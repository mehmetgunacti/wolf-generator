import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { AuthUserDTO, successNotification } from 'blueprints';
import { Entities } from 'blueprints/constant/entity.constant';
import { switchMap } from 'rxjs/operators';
import { AuthService } from 'services';
import {
	activateOnline, autoLogin, changePassword, deactivateOnline, disableAccount,
	enableAccount,
	login,
	loginSuccess,
	logout, register, remindPassword,
	toggleRole
} from 'store/actions';
import { loadEntities, storeDTO } from 'store/actions/entity.action';
import { navigate } from 'store/actions/navigation.action';
import { showNotification } from 'store/actions/notification.action';

@Injectable()
export class SessionEffects {

	constructor(
		private actions$: Actions,
		private authService: AuthService
	) { }

	login$ = createEffect(

		() => this.actions$.pipe(

			ofType(login),
			switchMap(({ dto }) =>

				this.authService.login(dto).pipe(

					switchMap(
						(dto: AuthUserDTO) => [
							loginSuccess({ dto }),
							loadEntities({ entity: Entities.constants }),
							navigate({ url: '' }),
							activateOnline()
						]
					)

				)

			)

		)

	);

	logout$ = createEffect(

		() => this.actions$.pipe(

			ofType(logout),
			switchMap(_ => [

				navigate({ url: '/' }),
				deactivateOnline()

			])

		)

	);

	remindPassword$ = createEffect(

		() => this.actions$.pipe(

			ofType(remindPassword),
			switchMap(params =>

				this.authService.remindPassword(params['dto']).pipe(

					switchMap(() => [
						navigate({ url: '' }),
						showNotification({
							...successNotification,
							title: 'New password created',
							message: 'Check your email'
						})
					])

				)

			)

		)

	);

	changePassword$ = createEffect(

		() => this.actions$.pipe(

			ofType(changePassword),
			switchMap(params =>

				this.authService.changePassword(params['dto']).pipe(

					switchMap(() => [
						navigate({ url: '' }),
						showNotification({
							...successNotification,
							title: 'Password changed'
						})
					])

				)

			)

		)

	);

	register$ = createEffect(

		() => this.actions$.pipe(

			ofType(register),
			switchMap(({ dto }) =>

				this.authService.register(dto).pipe(

					switchMap(() => [
						navigate({ url: '' }),
						showNotification({
							...successNotification,
							title: 'User created',
							message: 'Notification email sent'
						})
					])

				)

			)

		)

	);

	toggleRole$ = createEffect(

		() => this.actions$.pipe(

			ofType(toggleRole),
			switchMap(params =>

				this.authService.toggleRole(params['id'], params['role']).pipe(

					switchMap(dto => [
						storeDTO({ dto }),
						showNotification({
							...successNotification,
							title: 'Success',
							message: 'Role granted'
						})
					])

				)

			)

		)

	);

	enableUserAccount$ = createEffect(

		() => this.actions$.pipe(

			ofType(enableAccount),
			switchMap(params =>

				this.authService.enableAccount(params['id']).pipe(

					switchMap(dto => [
						storeDTO({ dto }),
						showNotification({
							...successNotification,
							title: 'Success',
							message: 'User account enabled'
						})
					])

				)

			)

		)

	);

	disableUserAccount$ = createEffect(

		() => this.actions$.pipe(

			ofType(disableAccount),
			switchMap(params =>

				this.authService.disableAccount(params['id']).pipe(

					switchMap(dto => [
						storeDTO({ dto }),
						showNotification({
							...successNotification,
							title: 'Success',
							message: 'User account disabled'
						})
					])

				)

			)

		)

	);

	autoLogin$ = createEffect(

		() => this.actions$.pipe(

			ofType(autoLogin),
			switchMap(({ token }) =>

				this.authService.autoLogin(token).pipe(

					switchMap(dto => [
						loginSuccess({ dto }),
						loadEntities({ entity: Entities.constants }),
						activateOnline()
					])

				)

			)

		)

	);

}
