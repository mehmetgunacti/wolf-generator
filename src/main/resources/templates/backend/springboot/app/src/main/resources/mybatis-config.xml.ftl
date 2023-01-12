<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
		PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
		"http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<settings>
		<setting name="mapUnderscoreToCamelCase" value="true"/>
	</settings>
	<typeAliases>
		<package name="${ info.groupId }.messaging"/>
		<package name="${ info.groupId }.entity.auth"/>
		<package name="${ info.groupId }.entity.constant"/>
		<package name="${ info.groupId }.entity.email"/>
		<package name="${ info.groupId }.entity.user"/>
		<#list entities as entity>
		<package name="${ info.groupId }.entity.${ entity.name.singular }"/>
		</#list>
	</typeAliases>
</configuration>