import { ChangeDetectionStrategy, Component, EventEmitter, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { User } from 'blueprints';
import { RegisterDTO } from 'blueprints/dto/register.dto';
import { isInvalid } from 'modules/shared';

@Component({
	selector: 'app-register-form',
	templateUrl: './register-form.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class RegisterFormComponent {

	form: FormGroup;

	@Output() register: EventEmitter<RegisterDTO> = new EventEmitter();

	constructor(
		fb: FormBuilder
	) {

		this.form = fb.group({
			username: ['', Validators.required],
			name: ['', Validators.required],
			title: [''],
			birthdate: [''],
			mobile: [''],
			phone: ['']
		});

	}

	onSave(): void {

		if (isInvalid(this.form))
			return;

		this.register.emit(this.form.value);

	}

}
