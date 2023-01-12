import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { Entities } from 'blueprints';
import * as actions from 'store/actions';

@Component({
	selector: 'app-constant-list-page',
	templateUrl: './constant-list-page.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ConstantListPageComponent {

	constructor(private store: Store) {}

	onRefresh(): void {

		this.store.dispatch(actions.loadEntities({ entity: Entities.constants, skipCache: true }));

	}

}
