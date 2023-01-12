<p-fieldset [legend]="'whoIsOnline' | translate"
			class="w-full lg:w-10 xl:w-6">

	<p-table [value]="(onlineUsers$ | async) || []"
			 [responsive]="true">
		<ng-template pTemplate="body"
					 let-user>
			<tr>
				<td>
					<span class="p-column-title">Name</span><i class="fas fa-fw fa-signal green"></i> {{ user.name }} ({{ user.username }})
				</td>
			</tr>
		</ng-template>
		<ng-template pTemplate="emptymessage"
					 let-columns>
			<tr>
				<td [attr.colspan]="1">
					<div class="flex align-items-center justify-content-center">
						<i class="fas fa-fw fa-signal"></i>&nbsp;No users are online
					</div>
				</td>
			</tr>
		</ng-template>
	</p-table>


</p-fieldset>
