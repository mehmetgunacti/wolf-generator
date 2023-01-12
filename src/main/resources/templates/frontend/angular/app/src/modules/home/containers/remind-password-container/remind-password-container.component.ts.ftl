import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { RemindPasswordDTO } from 'blueprints/dto';
import * as actions from 'store';

@Component({
	selector: 'app-remind-password-container',
	templateUrl: './remind-password-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class RemindPasswordContainerComponent {

	constructor(private store: Store) { }

	onRemindPassword(dto: RemindPasswordDTO): void {

		this.store.dispatch(actions.remindPassword({ dto }));

	}

}
