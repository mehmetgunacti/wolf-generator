import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { Constant, Entities } from 'blueprints';
import { Observable } from 'rxjs';
import * as actions from 'store';
import * as selectors from 'store';

@Component({
	selector: 'app-constant-list-container',
	templateUrl: './constant-list-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ConstantListContainerComponent {

	constants$: Observable<Constant[]>;
	categories$: Observable<string[]>;
	selectedCategory$: Observable<string>;

	constructor(
		private store: Store
	) {

		this.constants$ = store.select(selectors.constantFilteredBySelectedCategory);
		this.categories$ = store.select(selectors.constantCategoriesAll);
		this.selectedCategory$ = store.select(selectors.constantSelectedCategory);

	}

	onRefresh(): void {

		this.store.dispatch(
			actions.loadEntities({
				entity: Entities.constants,
				skipCache: true
			})
		);

	}

	onSave(constant: Constant): void {

		this.store.dispatch(
			actions.createEntity({
				entity: Entities.constants,
				body: constant,
				after: { redirect: false, showSuccess: true }
			})
		);

	}

}
