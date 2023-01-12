<p-fieldset legend="Edit">

	<div *ngIf="${ entity.name.singular }$ | async as ${ entity.name.singular } else nodata">

		<div class="p-fieldset-legend fieldset-right">
			<button pButton
					label="Cancel"
					icon="fas fa-times"
					[routerLink]="['/${ entity.name.plural.kebab }', ${ entity.name.singular }.id]"
					class="p-button-text p-button-sm"></button>
		</div>
		<app-${ entity.name.singular.kebab }-form [${ entity.name.singular }]="${ entity.name.singular }"
					   (save)="onSave($event)"></app-${ entity.name.singular.kebab }-form>

	</div>
	<ng-template #nodata>

		<div class="p-fieldset-legend fieldset-right">
			<button pButton
					label="Go back"
					icon="fas fa-undo-alt"
					[routerLink]="['/${ entity.name.plural.kebab }']"
					class="p-button-text p-button-sm"></button>
		</div>
		<div class="flex justify-content-between align-items-center">
			No content to display
		</div>

	</ng-template>

</p-fieldset>
