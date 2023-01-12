<div *ngIf="${ entity.name.singular }"
		class="p-fluid formgrid">

<#list entity.fields as field>
	<div class="field w-full md-6">

		<label>${ field.name.words }</label>
		<div class="p-2">{{ ${ entity.name.singular }.${ field.name } }}</div>

	</div>
</#list>
</div>