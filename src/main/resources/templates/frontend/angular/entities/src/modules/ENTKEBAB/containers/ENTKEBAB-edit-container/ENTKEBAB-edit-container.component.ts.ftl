import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { Entities, ${ entity.name.singular.pascal } } from 'blueprints';
import { Observable } from 'rxjs';
import * as actions from 'store';
import * as selectors from 'store';

@Component({
	selector: 'app-${ entity.name.singular.kebab }-edit-container',
	templateUrl: './${ entity.name.singular.kebab }-edit-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ${ entity.name.singular.pascal }EditContainerComponent {

	${ entity.name.singular }$: Observable<${ entity.name.singular.pascal }>;

	constructor(
		private store: Store
	) {

		this.${ entity.name.singular }$ = store.select(selectors.activeEntity);

	}

	onSave(${ entity.name.singular }: ${ entity.name.singular.pascal }): void {

		this.store.dispatch(
			actions.modifyEntity({
				entity: Entities.${ entity.name.plural },
				id: ${ entity.name.singular }.id,
				body: ${ entity.name.singular },
				after: { redirect: true, showSuccess: true }
			})
		);

	}

}
