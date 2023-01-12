<p-fieldset legend="User">

	<div *ngIf="user$ | async as user else nodata">

		<div class="p-fieldset-legend fieldset-right">
			<ng-container *appHasRole="AuthRole.AUTH_USER_EDIT; else elseBlock">
				<button pButton
						#deleteBtn
						label="Delete"
						icon="fas fa-trash"
						(click)="onDelete(user.id, deleteBtn)"
						class="p-button-text p-button-danger p-button-sm"></button>
				<button pButton
						label="Edit"
						icon="fas fa-edit"
						[routerLink]="['/admin/users', user.id, 'edit']"
						class="p-button-text p-button-sm"></button>
			</ng-container>
			<ng-template #elseBlock>
				<div style="background-color: red; color: white;">Else Block Visible</div>
			</ng-template>
			<button pButton
					label="Refresh"
					icon="fas fa-sync-alt"
					(click)="onRefresh(user.id)"
					class="p-button-text p-button-sm"></button>
		</div>
		<app-user-info [user]="user$ | async"></app-user-info>
		<p-tabView>
			<p-tabPanel>
				<ng-template pTemplate="header">
					<div class="flex p-ai-baseline">
						<i class="fas fa-user mr-1"></i>
						<span>Account</span>
					</div>
				</ng-template>
				<app-auth-user-account-info [user]="user"
											(enableAccount)="onEnableAccount(user.id)"
											(disableAccount)="onDisableAccount(user.id)"></app-auth-user-account-info>
			</p-tabPanel>
			<p-tabPanel>
				<ng-template pTemplate="header">
					<div class="flex p-ai-baseline">
						<i class="fas fa-user mr-1"></i>
						<span>Password</span>
					</div>
				</ng-template>
				<app-auth-user-password [user]="user"></app-auth-user-password>
			</p-tabPanel>
			<p-tabPanel *appHasRole="AuthRole.AUTH_USER_MANAGE">
				<ng-template pTemplate="header">
					<div class="flex p-ai-baseline">
						<i class="fas fa-user-shield mr-1"></i>
						<span>Roles</span>
					</div>
				</ng-template>
				<app-auth-user-auth-form [userRoles]="user.roles || []"
										 (role)="onRole($event, user.id)"></app-auth-user-auth-form>
			</p-tabPanel>
		</p-tabView>

	</div>
	<ng-template #nodata>

		<div class="p-fieldset-legend fieldset-right">
			<button pButton
					label="Go back"
					icon="fas fa-undo-alt"
					routerLink="/admin/users"
					class="p-button-text p-button-sm ml-auto"></button>
		</div>
		<div class="flex justify-content-between align-items-center">
			No content to display
		</div>

	</ng-template>

</p-fieldset>
