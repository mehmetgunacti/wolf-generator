package com.wolf359apps.bizimofis.constant;

/**
 * Constants for Spring Security authorities.
 */
public final class AuthRole {

    public static final String AUTH_USER_VIEW   = "AUTH_USER_VIEW";
    public static final String AUTH_USER_EDIT   = "AUTH_USER_EDIT";
    public static final String AUTH_USER_MANAGE = "AUTH_USER_MANAGE";

    public static final String CONSTANT_MANAGE = "CONSTANT_MANAGE";

    <#list entities as entity>
    public static final String ${ entity.name.singular.snake.uppercase }_VIEW   = "${ entity.name.singular.snake.uppercase }_VIEW";
    public static final String ${ entity.name.singular.snake.uppercase }_ADD    = "${ entity.name.singular.snake.uppercase }_ADD";
    public static final String ${ entity.name.singular.snake.uppercase }_EDIT   = "${ entity.name.singular.snake.uppercase }_EDIT";
    public static final String ${ entity.name.singular.snake.uppercase }_DELETE = "${ entity.name.singular.snake.uppercase }_DELETE";
    </#list>

}
