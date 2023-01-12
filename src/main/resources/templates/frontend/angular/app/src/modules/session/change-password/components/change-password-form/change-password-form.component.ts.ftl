import { ChangeDetectionStrategy, Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ChangePasswordDTO } from 'blueprints/dto/change-password.dto';
import { passwordMatchValidator } from 'utils';

@Component({
	selector: 'app-change-password-form',
	templateUrl: './change-password-form.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ChangePasswordFormComponent implements OnChanges {

	form: FormGroup;

	@Input() username: string | null | undefined;

	@Output() changePassword = new EventEmitter<ChangePasswordDTO>();

	constructor(fb: FormBuilder) {

		this.form = fb.group({
			username: [{ value: null, disabled: true }, Validators.required],
			currentPassword: [null, Validators.required],
			newPassword: [null, Validators.required],
			retypePassword: [null, Validators.required]
		}, { validators: passwordMatchValidator });

	}

	ngOnChanges(changes: SimpleChanges): void {

		const fcUsername: AbstractControl = this.form.controls['username'];
		const username = changes['username']?.currentValue;
		if (username)
			fcUsername.patchValue(username);
		else
			fcUsername.enable();

	}

	onChangePassword(event: any): void {

		const formValues = this.form.getRawValue();
		this.changePassword.emit({

			username: formValues.username,
			password: formValues.currentPassword,
			newPassword: formValues.newPassword

		});

	}

}
