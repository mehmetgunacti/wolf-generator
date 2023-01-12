import { ChangeDetectionStrategy, Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ${ entity.name.singular.pascal } } from 'blueprints';
import { isInvalid } from 'modules/shared';

@Component({
	selector: 'app-${ entity.name.singular.kebab }-form',
	templateUrl: './${ entity.name.singular.kebab }-form.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ${ entity.name.singular.pascal }FormComponent implements OnChanges {

	@Input() ${ entity.name.singular }: ${ entity.name.singular.pascal } | null | undefined;

	@Output() save: EventEmitter<${ entity.name.singular.pascal }> = new EventEmitter();

	form: FormGroup;

	constructor(
		fb: FormBuilder
	) {

		this.form = fb.group({
			id: [''],
			<#list entity.fields as field>
			${ field.name }: [''<#if field.required>, Validators.required</#if>],
			</#list>
		});

	}

	ngOnChanges(changes: SimpleChanges): void {

		const ${ entity.name.singular }: ${ entity.name.singular.pascal } = changes['${ entity.name.singular }']?.currentValue;
		if (${ entity.name.singular })
			this.form.patchValue({
				...${ entity.name.singular },
                <#list entity.fields as field>
                <#if field.type == 'timestamp' || field.type == 'date' >
                ${ field.name }: new Date(${ entity.name.singular }.${ field.name }),
                </#if>
                </#list>
			});

	}

	onSave(): void {

		if (isInvalid(this.form))
			return;

		this.save.emit(this.form.value);

	}

}
