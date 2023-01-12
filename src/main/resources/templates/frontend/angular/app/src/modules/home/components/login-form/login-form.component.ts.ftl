import { ChangeDetectionStrategy, Component, EventEmitter, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { LoginDTO } from 'blueprints/dto/login.dto';

@Component({
	selector: 'app-login-form',
	templateUrl: './login-form.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class LoginFormComponent {

	form: FormGroup;

	@Output() login: EventEmitter<LoginDTO> = new EventEmitter();
	@Output() saveToken: EventEmitter<boolean> = new EventEmitter();

	constructor(fb: FormBuilder) {

		this.form = fb.group({
			username: ['admin', Validators.required],
			password: ['123456']
		});

	}

	onLogin(): void {

		this.login.emit(this.form.value);

	}

	onSaveToken(checked: boolean): void {

		this.saveToken.emit(checked);

	}

}
