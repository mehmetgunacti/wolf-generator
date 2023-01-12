<div *ngIf="user">

	<table class="padded-table"
		   style="width: 100%">
		<tr>
			<td style="width: 15rem;">Created</td>
			<td>{{ user.created | date:'medium'}}</td>
		</tr>
		<tr>
			<td>Modified</td>
			<td>{{ user.modified | date:'medium'}}</td>
		</tr>
		<tr>
			<td>Status</td>
			<td>
				<button *appHasRole="AuthRole.AUTH_USER_MANAGE; else elseBlock"
						pButton
						[label]="user.accountEnabled?'ENABLED':'DISABLED'"
						[icon]="user.accountEnabled?'fas fa-lock-open':'fas fa-lock'"
						(click)="toggleAccount()"
						[ngClass]="{'p-button-success': user.accountEnabled, 'p-button-danger': !user.accountEnabled}"
						class="p-button-sm"></button>
				<ng-template #elseBlock>
					<p-tag [icon]="user.accountEnabled?'fas fa-lock-open':'fas fa-lock'"
						   [value]="user.accountEnabled?'ENABLED':'DISABLED'"
						   [severity]="user.accountEnabled ? 'success' : 'danger'"></p-tag>
				</ng-template>

			</td>
		</tr>
		<tr>
			<td>Expiration</td>
			<td>{{ user.accountExpiration | date:'medium' }}</td>
		</tr>
		<tr>
			<td>Last login</td>
			<td>{{ user.lastLogin | date:'medium' }}</td>
		</tr>
	</table>

</div>
