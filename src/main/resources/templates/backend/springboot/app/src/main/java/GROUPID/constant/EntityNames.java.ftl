package com.wolf359apps.bizimofis.constant;

public enum EntityNames {

    authUsers,
    constants,
    onlineUsers,
    users,
    <#list entities as entity>
    ${ entity.name.plural }<#sep>,</#sep>
    </#list>

}
