import { ChangeDetectionStrategy, Component, OnInit } from '@angular/core';
import { Store } from '@ngrx/store';
import { AuthRole, Entities, ${ entity.name.singular.pascal } } from 'blueprints';
import { Observable } from 'rxjs';
import * as actions from 'store';
import * as selectors from 'store';

@Component({
	selector: 'app-${ entity.name.singular.kebab }-list-container',
	templateUrl: './${ entity.name.singular.kebab }-list-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ${ entity.name.singular.pascal }ListContainerComponent implements OnInit {

	AuthRole= AuthRole;

	${ entity.name.plural }$: Observable<${ entity.name.singular.pascal }[]>;

	constructor(
		private store: Store
	) {

		this.${ entity.name.plural }$ = store.select(selectors.activeEntities);

	}

	ngOnInit(): void {

		this.store.dispatch(
			actions.loadEntities({
				entity: Entities.${ entity.name.plural }
			})
		);

	}

	onRefresh(): void {

		this.store.dispatch(
			actions.loadEntities({
				entity: Entities.${ entity.name.plural },
				skipCache: true
			})
		);

	}

}
