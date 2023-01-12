import { ChangeDetectionStrategy, Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AuthUser } from 'blueprints';
import { isInvalid } from 'modules/shared';

@Component({
	selector: 'app-auth-user-form',
	templateUrl: './auth-user-form.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class AuthUserFormComponent implements OnChanges {

	@Input() user: AuthUser | null | undefined;

	@Output() save: EventEmitter<AuthUser> = new EventEmitter();

	form: FormGroup;

	constructor(
		fb: FormBuilder
	) {

		this.form = fb.group({
			id: [''],
			name: ['', Validators.required],
			title: [''],
			birthdate: [''],
			mobile: [''],
			phone: [''],
			username: ['', Validators.required]
		});

	}

	ngOnChanges(changes: SimpleChanges): void {

		const user = changes['user']?.['currentValue'];
		if (user)
			this.form.patchValue({
				...user,
				birthdate: new Date(user.birthdate)
			});

	}

	onSave(): void {

		if (isInvalid(this.form))
			return;

		this.save.emit(this.form.value);

	}

	print(): void {

		console.log(this.form);

	}

}
