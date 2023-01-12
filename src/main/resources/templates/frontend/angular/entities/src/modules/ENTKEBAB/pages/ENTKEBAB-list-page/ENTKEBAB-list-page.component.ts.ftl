import { ChangeDetectionStrategy, Component, OnInit } from '@angular/core';
import { Store } from '@ngrx/store';
import { Entities } from 'blueprints';
import * as actions from 'store';

@Component({
	selector: 'app-${ entity.name.singular.kebab }-list-page',
	templateUrl: './${ entity.name.singular.kebab }-list-page.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ${ entity.name.singular.pascal }ListPageComponent implements OnInit {

	constructor(private store: Store) { }

	ngOnInit(): void {

		this.store.dispatch(
			actions.activateEntity({
				entityName: Entities.${ entity.name.plural }.plural
			})
		);

	}

}
