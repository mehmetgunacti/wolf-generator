export enum AuthRole {

	AUTH_USER_VIEW				= 'AUTH_USER_VIEW',
	AUTH_USER_EDIT				= 'AUTH_USER_EDIT',
	AUTH_USER_MANAGE			= 'AUTH_USER_MANAGE',

	CONSTANT_MANAGE = 'CONSTANT_MANAGE',
<#list entities as entity>

	${ entity.name.singular.snake.uppercase }_VIEW	    = '${ entity.name.singular.snake.uppercase }_VIEW',
	${ entity.name.singular.snake.uppercase }_ADD	    = '${ entity.name.singular.snake.uppercase }_ADD',
	${ entity.name.singular.snake.uppercase }_EDIT	    = '${ entity.name.singular.snake.uppercase }_EDIT',
	${ entity.name.singular.snake.uppercase }_DELETE	= '${ entity.name.singular.snake.uppercase }_DELETE'<#sep>,</#sep>
</#list>

}
