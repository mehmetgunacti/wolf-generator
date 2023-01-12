<p-fieldset legend="${ entity.name.plural.pascal }">

	<div class="p-fieldset-legend fieldset-right">
		<button *appHasRole="AuthRole.${ entity.name.singular.snake.uppercase }_ADD"
				pButton
				routerLink="/${ entity.name.plural.kebab }/new"
				label="New ${ entity.name.singular.pascal }"
				icon="fas fa-plus"
				class="p-button-text p-button-sm"></button>
		<button pButton
				label="Refresh"
				icon="fas fa-sync-alt"
				(click)="onRefresh()"
				class="p-button-text p-button-sm ml-2"></button>
	</div>
	<app-${ entity.name.singular.kebab }-list [${ entity.name.plural }]="${ entity.name.plural }$ | async"></app-${ entity.name.singular.kebab }-list>

</p-fieldset>
