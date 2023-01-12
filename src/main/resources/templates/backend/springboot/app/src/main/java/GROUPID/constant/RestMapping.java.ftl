package ${ info.groupId }.constant;

public class RestMapping {

    public static final String USERS    = "/users";
    public static final String USERS_ID = "/users/{id}";

    public static final String AUTH_LOGIN               = "/auth/login";
    public static final String AUTH_REMIND_PASSWORD     = "/auth/remind-password";
    public static final String AUTH_CHANGE_PASSWORD     = "/auth/change-password";
    public static final String AUTH_REGISTER            = "/auth/register";
    public static final String AUTH_USERS               = "/auth/users";
    public static final String AUTH_USERS_ID            = "/auth/users/{id}";
    public static final String AUTH_USERS_ID_ROLES_ROLE = "/auth/users/{id}/roles/{role}";
    public static final String AUTH_USERS_ID_ENABLE     = "/auth/users/{id}/enable";
    public static final String AUTH_USERS_ID_DISABLE    = "/auth/users/{id}/disable";
    public static final String AUTH_ONLINE              = "/auth/online";
    public static final String AUTH_ONLINE_LIST         = "/auth/online/list";
    public static final String AUTH_ONLINE_ID           = "/auth/online/{id}";

    public static final String AUTH_CONSTANTS      = "/auth/constants";
    public static final String AUTH_CONSTANTS_CODE = "/auth/constants/{code}";
    <#list entities as entity>

	public static final String ${ entity.name.plural.snake.uppercase }    = "/${ entity.name.plural.kebab }";
	public static final String ${ entity.name.plural.snake.uppercase }_ID = "/${ entity.name.plural.kebab }/{id}";
    </#list>

    public static final String TOPIC_WHO_IS_ONLINE          = "/topic/whoIsOnline";
    public static final String TOPIC_LOGGED_IN_USER_CHANGES = "/topic/loggedInUserChanges/{id}";

    public static final String QUEUE_PING_ID = "/queue/ping/{id}";

}
