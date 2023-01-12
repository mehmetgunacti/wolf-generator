<p-fieldset legend="New">

	<div>

		<div class="p-fieldset-legend fieldset-right">
			<button pButton
					label="Cancel"
					icon="fas fa-times"
					[routerLink]="['/admin/users']"
					class="p-button-text p-button-sm"></button>
		</div>
		<app-auth-user-form (save)="onSave($event)"></app-auth-user-form>

	</div>

</p-fieldset>
