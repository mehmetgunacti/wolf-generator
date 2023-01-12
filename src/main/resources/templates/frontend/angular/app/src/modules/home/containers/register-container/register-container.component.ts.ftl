import { ChangeDetectionStrategy, Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Store } from '@ngrx/store';
import { RegisterDTO } from 'blueprints/dto/register.dto';
import * as fromStore from 'store';

@Component({
	selector: 'app-register-container',
	templateUrl: './register-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class RegisterContainerComponent {

	form: FormGroup;

	constructor(
		private store: Store,
		fb: FormBuilder
	) {

		this.form = fb.group({
			username: ['admin', Validators.required],
			password: ['123456'],
			rememberme: []
		});

	}

	onRegister(dto: RegisterDTO): void {

		this.store.dispatch(fromStore.register({ dto }));

	}

}
