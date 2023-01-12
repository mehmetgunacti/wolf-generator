<div *ngIf="user">

	<table class="padded-table"
		   style="width: 100%">
		<tr>
			<td style="width: 15rem;">Status</td>
			<td>
				<p-tag styleClass="py-1 px-2"
					   [icon]="user.passwordLocked?'fas fa-hourglass-end':'fas fa-hourglass-half'"
					   [severity]="user.passwordLocked?'danger':'success'"
					   [value]="user.passwordLocked?'EXPIRED':'ACTIVE'"></p-tag>
			</td>
		</tr>
		<tr>
			<td>Expiration</td>
			<td>{{ user.passwordExpiration | date:'medium' }}</td>
		</tr>
	</table>

</div>
