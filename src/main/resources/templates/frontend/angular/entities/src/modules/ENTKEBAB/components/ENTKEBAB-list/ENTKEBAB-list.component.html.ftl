<p-table [value]="${ entity.name.plural } || []"
		 styleClass="p-datatable-striped"
		 [responsive]="true"
		 selectionMode="single">
	<ng-template pTemplate="header">
		<tr>
		    <#list entity.fields as field>
			<th>${ field.name.words }</th>
			</#list>
		</tr>
	</ng-template>
	<ng-template pTemplate="body"
				 let-${ entity.name.singular }>
		<tr routerLink="/${ entity.name.plural.kebab }/{{ ${ entity.name.singular }.id }}" [pSelectableRow]="${ entity.name.singular }">
		    <#list entity.fields as field>
                <td><span class="p-column-title">${ field.name.pascal }</span>{{ ${ entity.name.singular }.${ field.name } }}</td>
            </#list>
		</tr>
	</ng-template>
	<ng-template pTemplate="emptymessage"
				 let-columns>
		<tr>
			<td [attr.colspan]="${ entity.fields?size }">
				<div class="flex align-items-center justify-content-center">
					No content to display
				</div>
			</td>
		</tr>
	</ng-template>
</p-table>
