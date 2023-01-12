import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { Entities, ${ entity.name.singular.pascal } } from 'blueprints';
import * as actions from 'store';

@Component({
	selector: 'app-${ entity.name.singular.kebab }-new-container',
	templateUrl: './${ entity.name.singular.kebab }-new-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ${ entity.name.singular.pascal }NewContainerComponent {

	constructor(
		private store: Store
	) {	}

	onSave(${ entity.name.singular }: ${ entity.name.singular.pascal }): void {

		this.store.dispatch(
			actions.createEntity({
				entity: Entities.${ entity.name.plural },
				body: ${ entity.name.singular },
				after: { redirect: true, showSuccess: true }
			})
		);

	}

}
