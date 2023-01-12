<p-fieldset legend="Edit">

	<div *ngIf="user$ | async as user else nodata">

		<div class="p-fieldset-legend fieldset-right">
			<button pButton
					label="Cancel"
					icon="fas fa-times"
					[routerLink]="['/admin', 'users', user.id]"
					class="p-button-text p-button-sm"></button>
		</div>
		<app-auth-user-form [user]="user"
							(save)="onSave($event)"></app-auth-user-form>

	</div>
	<ng-template #nodata>

		<div class="p-fieldset-legend fieldset-right">
			<button pButton
					label="Go back"
					icon="fas fa-undo-alt"
					[routerLink]="['users']"
					class="p-button-text p-button-sm"></button>
		</div>
		<div class="flex justify-content-between align-items-center">
			No content to display
		</div>

	</ng-template>

</p-fieldset>
