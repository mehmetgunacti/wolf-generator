<p-fieldset legend="Constants">

	<div class="p-fieldset-legend fieldset-right">
		<button pButton
				label="New Constant"
				icon="fas fa-plus"
				class="p-button-text p-button-sm"
				(click)="createOverlay.toggle($event)"></button>
		<p-overlayPanel #createOverlay
						[showCloseIcon]="true"
						[style]="{width: '450px'}">
			<ng-template pTemplate>
				<app-constant-form [selectedCategory]="selectedCategory$ | async"
								   [categories]="categories$ | async"
								   (save)="onSave($event)"></app-constant-form>
			</ng-template>
		</p-overlayPanel>
		<button pButton
				label="Refresh"
				icon="fas fa-sync-alt"
				(click)="onRefresh()"
				class="p-button-text p-button-sm ml-2"></button>
	</div>
	<app-constant-list></app-constant-list>

</p-fieldset>
