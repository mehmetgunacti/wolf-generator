import { ChangeDetectionStrategy, Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Constant } from 'blueprints';
import { isInvalid } from 'modules/shared';

@Component({
	selector: 'app-constant-form',
	templateUrl: './constant-form.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ConstantFormComponent implements OnChanges {

	@Input() selectedCategory: string | null | undefined;
	@Input() categories: string[] | null = [];

	@Output() save: EventEmitter<Constant> = new EventEmitter();

	form: FormGroup;

	constructor(
		fb: FormBuilder
	) {

		this.form = fb.group({
			code: ['', Validators.required],
			name: ['', Validators.required],
			category: ['', Validators.required]
		});

	}

	ngOnChanges(changes: SimpleChanges): void {

		const constant = changes['constant']?.currentValue;
		if (constant)
			this.form.patchValue({
				...constant
			});

		const selectedCategory = changes['selectedCategory']?.currentValue;
		if (selectedCategory)
			this.form.patchValue({
				category: selectedCategory
			});

	}

	onSave(): void {

		if (isInvalid(this.form))
			return;

		this.save.emit(this.form.value);

	}

}
