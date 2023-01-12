import { Injectable } from '@angular/core';
import { Actions, concatLatestFrom, createEffect, ofType } from '@ngrx/effects';
import { Store } from '@ngrx/store';
import { successNotification } from 'blueprints';
import { capitalize } from 'lodash-es';
import { map, switchMap } from 'rxjs/operators';
import { EntityService } from 'services/entity.service';
import { activateEntity, createEntity, deactivateEntity, deleteEntity, loadEntities, loadEntity, modifyEntity, storeDTO } from 'store/actions/entity.action';
import { navigate } from 'store/actions/navigation.action';
import { showNotification } from 'store/actions/notification.action';
import { activeEntitiesInitialized } from 'store/selectors/entity.selector';

@Injectable()
export class EntityEffects {

	constructor(
		private actions$: Actions,
		private store: Store,
		private entityService: EntityService
	) { }

	loadEntity$ = createEffect(

		() => this.actions$.pipe(

			ofType(loadEntity),
			switchMap(({ entity, id, skipCache }) =>

				this.entityService.loadOne(entity, id, skipCache).pipe(

					map(dto => storeDTO({ dto }))

				)

			)

		)

	);

	loadEntities$ = createEffect(

		() => this.actions$.pipe(

			ofType(loadEntities),
			concatLatestFrom(_ => this.store.select(activeEntitiesInitialized)),
			switchMap(([{ entity, skipCache }, initialized]) =>

				this.entityService.loadAll(entity, !initialized || skipCache).pipe(

					map(dto => storeDTO({ dto, emptyStore: true }))

				)

			)

		)

	);

	createEntity$ = createEffect(

		() => this.actions$.pipe(

			ofType(createEntity),
			switchMap(({ entity, body, after }) =>

				this.entityService.create(entity, body).pipe(

					switchMap(dto => {

						const createdId = dto.data[entity.plural].ids[0];
						const actions = new Array();

						actions.push(storeDTO({ dto }));
						actions.push(activateEntity({ entityName: entity.plural, id: createdId }));

						if (after.redirect)
							actions.push(navigate({ url: entity.routeUrl(createdId) }));

						if (after.showSuccess)
							actions.push(
								showNotification({
									...successNotification,
									title: 'Success',
									message: `${r"${capitalize(entity.name)}"} created`
								})
							);

						return actions;

					})

				)

			)

		)

	);

	modifyEntity$ = createEffect(

		() => this.actions$.pipe(

			ofType(modifyEntity),
			switchMap(({ entity, id, body, after }) =>

				this.entityService.modify(entity, id, body).pipe(

					switchMap(dto => {

						const actions = new Array();
						actions.push(storeDTO({ dto }));

						if (after.redirect)
							actions.push(navigate({ url: entity.routeUrl(id) }));

						if (after.showSuccess)
							actions.push(
								showNotification({
									...successNotification,
									title: 'Success',
									message: `${r"${capitalize(entity.name)}"} updated`
								})
							);

						return actions;

					})

				)

			)

		)

	);

	deleteEntity$ = createEffect(

		() => this.actions$.pipe(

			ofType(deleteEntity),
			switchMap(({ entity, id }) =>

				this.entityService.delete(entity, id).pipe(

					switchMap(dto => [
						storeDTO({ dto }), // returning dto: 'ids' contains id, entities is empty => store will delete entry
						deactivateEntity({ key: entity.plural }),
						navigate({ url: entity.routeUrl() }),
						showNotification({
							...successNotification,
							title: 'Success',
							message: `${r"${capitalize(entity.name)}"} deleted`
						})
					])

				)

			)

		)

	);

}
