import { ChangeDetectionStrategy, Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { RemindPasswordDTO } from 'blueprints/dto';

@Component({
	selector: 'app-remind-password-form',
	templateUrl: './remind-password-form.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class RemindPasswordFormComponent {

	form: FormGroup;

	@Output() remindPassword = new EventEmitter<RemindPasswordDTO>();

	constructor(fb: FormBuilder) {

		this.form = fb.group({
			username: [null, Validators.required]
		});

	}

	onRemindPassword(): void {

		this.remindPassword.emit(this.form.value);

	}

}
