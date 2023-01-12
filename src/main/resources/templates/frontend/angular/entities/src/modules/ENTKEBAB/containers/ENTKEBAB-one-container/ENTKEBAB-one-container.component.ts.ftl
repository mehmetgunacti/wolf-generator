import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { AuthRole, Entities, ID, ${ entity.name.singular.pascal } } from 'blueprints';
import { ConfirmationService } from 'primeng/api';
import { Observable } from 'rxjs';
import * as actions from 'store';
import * as selectors from 'store';

@Component({
	selector: 'app-${ entity.name.singular.kebab }-one-container',
	templateUrl: './${ entity.name.singular.kebab }-one-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ${ entity.name.singular.pascal }OneContainerComponent {

	AuthRole= AuthRole;

	${ entity.name.singular }$: Observable<${ entity.name.singular.pascal }>;

	constructor(
		private store: Store,
		private confirmationService: ConfirmationService
	) {

		this.${ entity.name.singular }$ = store.select(selectors.activeEntity);

	}

	onRefresh(id: ID): void {

		this.store.dispatch(
			actions.loadEntity({
				entity: Entities.${ entity.name.plural },
				id,
				skipCache: true
			})
		);

	}

	onDelete(id: ID, btn: HTMLButtonElement): void {

		this.confirmationService.confirm({
			target: btn,
			message: 'Are you sure that you want to proceed?',
			icon: 'fas fa-exclamation-triangle',
			acceptButtonStyleClass: 'p-button-danger',
			acceptLabel: 'Delete',
			accept: () => this.store.dispatch(actions.deleteEntity({ entity: Entities.${ entity.name.plural }, id }))
		});

	}

}
