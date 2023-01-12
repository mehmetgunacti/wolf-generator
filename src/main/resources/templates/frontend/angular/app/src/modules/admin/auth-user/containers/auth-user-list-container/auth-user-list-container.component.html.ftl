<p-fieldset legend="Users">

	<div class="p-fieldset-legend fieldset-right">
		<button *appHasRole="AuthRole.AUTH_USER_EDIT"
				pButton
				label="New User"
				icon="fas fa-user-plus"
				routerLink="/admin/users/new"
				class="p-button-text p-button-sm"></button>
		<button pButton
				label="Refresh"
				icon="fas fa-sync-alt"
				(click)="onRefresh()"
				class="p-button-text p-button-sm"></button>
	</div>
	<app-auth-user-list [users]="users$ | async"></app-auth-user-list>

</p-fieldset>
