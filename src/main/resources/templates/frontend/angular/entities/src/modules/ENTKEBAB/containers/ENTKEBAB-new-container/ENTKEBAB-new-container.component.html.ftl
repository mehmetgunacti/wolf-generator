<p-fieldset legend="New">

	<div>

		<div class="p-fieldset-legend fieldset-right">
			<button pButton
					label="Cancel"
					icon="fas fa-times"
					[routerLink]="['/${ entity.name.plural.kebab }']"
					class="p-button-text p-button-sm"></button>
		</div>
		<app-${ entity.name.singular.kebab }-form (save)="onSave($event)"></app-${ entity.name.singular.kebab }-form>

	</div>

</p-fieldset>
