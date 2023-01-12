<form [formGroup]="form">

	<div class="p-fluid formgrid">

    <#list entity.fields as field>
		<div class="field">

			<label for="${ field.name }">${ field.name }</label>
            <#switch field.type>

                <#case "timestamp">
                    <p-calendar inputId="${ field.name }"
                                formControlName="${ field.name }"
                                [showTime]="true"></p-calendar>
                <#break>

                <#case "date">
                    <p-calendar inputId="${ field.name }"
                                            formControlName="${ field.name }"></p-calendar>
                <#break>

                <#case "bool">
                    <p-inputSwitch id="${ field.name }"
                                   class="p-d-flex"
                                   formControlName="${ field.name }"></p-inputSwitch>
                <#break>

                <#default>
                    <input id="${ field.name }"
                                       type="text"
                                       pInputText
                                       formControlName="${ field.name }">
            </#switch>
			<small *ngIf="form.controls['${ field.name }'].invalid && form.controls['${ field.name }'].dirty"
				   class="p-error">${ field.name.pascal } is not available.</small>

		</div>
	</#list>
	</div>

	<div class="flex">

		<button pButton
				label="Save"
				[disabled]="form.pristine || form.invalid"
				icon="fas fa-save"
				(click)="onSave()"
				class="p-button-raised ml-auto"></button>

	</div>

</form>
