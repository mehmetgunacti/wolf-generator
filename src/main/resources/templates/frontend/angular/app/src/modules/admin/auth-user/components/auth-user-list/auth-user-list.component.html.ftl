<p-table [value]="users || []"
		 styleClass="p-datatable-striped"
		 [responsive]="true"
		 selectionMode="single">
	<ng-template pTemplate="header">
		<tr>
			<th>Name (Username)</th>
			<th>Last Login</th>
			<th>Password Expiration</th>
			<th>Password Status</th>
			<th>Account Expiration</th>
			<th>Account Status</th>
		</tr>
	</ng-template>
	<ng-template pTemplate="body"
				 let-user>
		<tr routerLink="/admin/users/{{ user.id }}" [pSelectableRow]="user">
			<td><span class="p-column-title">Name</span>{{ user.name }} ({{ user.username }})</td>
			<td><span class="p-column-title">Last Login</span>{{ user.lastLogin | date:'short' }}</td>
			<td><span class="p-column-title">Password Expiration</span>{{ user.passwordExpiration | date:'short' }}</td>
			<td><span class="p-column-title">Password Status</span><p-tag styleClass="py-1 px-2" [icon]="user.accountLocked?'fas fa-lock':'fas fa-lock-open'" [severity]="user.accountLocked?'danger':'success'" [value]="user.accountLocked?'Locked':'Unlocked'"></p-tag></td>
			<td><span class="p-column-title">Account Expiration</span>{{ user.accountExpiration | date:'short' }}</td>
			<td><span class="p-column-title">Account Status</span><p-tag styleClass="py-1 px-2" [icon]="user.accountEnabled?'fas fa-lock-open':'fas fa-lock-open'" [severity]="user.accountEnabled?'success':'danger'" [value]="user.accountEnabled?'Enabled':'Disabled'"></p-tag></td>
		</tr>
	</ng-template>
	<ng-template pTemplate="emptymessage"
				 let-columns>
		<tr>
			<td [attr.colspan]="6">
				<div class="flex align-items-center justify-content-center">
					No content to display
				</div>
			</td>
		</tr>
	</ng-template>
</p-table>
