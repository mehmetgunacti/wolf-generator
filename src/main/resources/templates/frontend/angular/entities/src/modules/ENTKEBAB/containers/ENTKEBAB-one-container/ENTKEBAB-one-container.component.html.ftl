<p-fieldset legend="${ entity.name.singular.pascal }">

	<div *ngIf="${ entity.name.singular }$ | async as ${ entity.name.singular } else nodata">

		<div class="p-fieldset-legend fieldset-right">
			<button *appHasRole="AuthRole.${ entity.name.singular.snake.uppercase }_DELETE"
					pButton
					#deleteBtn
					label="Delete"
					icon="fas fa-trash"
					(click)="onDelete(${ entity.name.singular }.id, deleteBtn)"
					class="p-button-text p-button-danger p-button-sm"></button>
			<button *appHasRole="AuthRole.${ entity.name.singular.snake.uppercase }_EDIT"
					pButton
					label="Edit"
					icon="fas fa-edit"
					[routerLink]="['/${ entity.name.plural.kebab }', ${ entity.name.singular }.id, 'edit']"
					class="p-button-text p-button-sm ml-2"></button>
			<button pButton
					label="Refresh"
					icon="fas fa-sync-alt"
					(click)="onRefresh(${ entity.name.singular }.id)"
					class="p-button-text p-button-sm ml-2"></button>
		</div>
		<app-${ entity.name.singular.kebab }-one [${ entity.name.singular }]="${ entity.name.singular }$ | async"></app-${ entity.name.singular.kebab }-one>

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
