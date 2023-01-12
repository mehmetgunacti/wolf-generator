<div class="p-fluid px-md-3">

	<p-divider [align]="'left'"
			   class="mt-4 m-2">
		<div class="inline-flex align-items-center">
			<i class="fas fa-shield-alt mr-2"></i>
			<b>Users</b>
		</div>
	</p-divider>
	<div class="button-grid">
		<button pButton
				type="button"
				label="View"
				class="p-button-outlined p-button-secondary"
				[ngClass]="{'p-button-success': userRoles.includes(Role.AUTH_USER_VIEW), 'p-button-outlined p-button-secondary': !userRoles.includes(Role.AUTH_USER_VIEW)}"
				(click)="onRole(Role.AUTH_USER_VIEW)"
				pTooltip="View users (+ details)"
				tooltipPosition="top"></button>
		<button pButton
				type="button"
				label="Add / Edit"
				class=""
				[ngClass]="{'p-button-success': userRoles.includes(Role.AUTH_USER_EDIT), 'p-button-outlined p-button-secondary': !userRoles.includes(Role.AUTH_USER_EDIT)}"
				(click)="onRole(Role.AUTH_USER_EDIT)"
				pTooltip="Edit user info"
				tooltipPosition="top"></button>
		<button pButton
				type="button"
				label="Manage"
				class=""
				[ngClass]="{'p-button-success': userRoles.includes(Role.AUTH_USER_MANAGE), 'p-button-outlined p-button-secondary': !userRoles.includes(Role.AUTH_USER_MANAGE)}"
				(click)="onRole(Role.AUTH_USER_MANAGE)"
				pTooltip="Grant/revoke roles, change account status, delete users"
				tooltipPosition="top"></button>
	</div>

	<p-divider [align]="'left'"
			   class="mt-4 m-2">
		<div class="inline-flex align-items-center">
			<i class="fas fa-shield-alt mr-2"></i>
			<b>Codes</b>
		</div>
	</p-divider>
	<div class="button-grid">
		<button pButton
				type="button"
				label="View / Edit"
				class=""
				[ngClass]="{'p-button-success': userRoles.includes(Role.CONSTANT_MANAGE), 'p-button-outlined p-button-secondary': !userRoles.includes(Role.CONSTANT_MANAGE)}"
                (click)="onRole(Role.CONSTANT_MANAGE)"
				pTooltip="View and edit constants"
				tooltipPosition="top"></button>
	</div>

<#list entities as entity>
	<p-divider [align]="'left'"
			   class="mt-4 m-2">
		<div class="inline-flex align-items-center">
			<i class="fas fa-shield-alt mr-2"></i>
			<b>${ entity.name.plural.pascal }</b>
		</div>
	</p-divider>
	<div class="button-grid">
		<button pButton
				type="button"
				label="View"
				class=""
				[ngClass]="{'p-button-success': userRoles.includes(Role.${ entity.name.singular.snake.uppercase }_VIEW), 'p-button-outlined p-button-secondary': !userRoles.includes(Role.${ entity.name.singular.snake.uppercase }_VIEW)}"
				(click)="onRole(Role.${ entity.name.singular.snake.uppercase }_VIEW)"
				pTooltip="View ${ entity.name.plural } (+ details)"
				tooltipPosition="top"></button>
		<button pButton
				type="button"
				label="Add"
				class=""
				[ngClass]="{'p-button-success': userRoles.includes(Role.${ entity.name.singular.snake.uppercase }_ADD), 'p-button-outlined p-button-secondary': !userRoles.includes(Role.${ entity.name.singular.snake.uppercase }_ADD)}"
				(click)="onRole(Role.${ entity.name.singular.snake.uppercase }_ADD)"
				pTooltip="Add a ${ entity.name.singular.pascal }"
				tooltipPosition="top"></button>
		<button pButton
				type="button"
				label="Edit"
				class=""
				[ngClass]="{'p-button-success': userRoles.includes(Role.${ entity.name.singular.snake.uppercase }_EDIT), 'p-button-outlined p-button-secondary': !userRoles.includes(Role.${ entity.name.singular.snake.uppercase }_EDIT)}"
				(click)="onRole(Role.${ entity.name.singular.snake.uppercase }_EDIT)"
				pTooltip="Edit a ${ entity.name.singular.pascal }"
				tooltipPosition="top"></button>
		<button pButton
				type="button"
				label="Delete"
				class=""
				[ngClass]="{'p-button-success': userRoles.includes(Role.${ entity.name.singular.snake.uppercase }_DELETE), 'p-button-outlined p-button-secondary': !userRoles.includes(Role.${ entity.name.singular.snake.uppercase }_DELETE)}"
				(click)="onRole(Role.${ entity.name.singular.snake.uppercase }_DELETE)"
				pTooltip="Delete a ${ entity.name.singular.pascal }"
				tooltipPosition="top"></button>
	</div>
</#list>

</div>
