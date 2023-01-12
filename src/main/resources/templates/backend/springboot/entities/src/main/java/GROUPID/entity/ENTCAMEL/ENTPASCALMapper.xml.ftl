<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
		"http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${ info.groupId }.entity.${ entity.name.singular }.${ entity.name.singular.pascal }Mapper">

	<sql id="baseSQL">
		select
			id,
        <#list entity.fields as field>
			${ field.name }<#sep>,</#sep>
		</#list>
		from
			${ info.artifactId.camel.lowercase }.${ entity.name.plural.snake }
	</sql>

	<select id="findById"
			resultType="${ entity.name.singular.pascal }">
		<include refid="baseSQL"/>
		where
			id = ${r"#{ id }"}
	</select>

	<select id="findAll"
			resultType="${ entity.name.singular.pascal }">
		<include refid="baseSQL"/>
	</select>

	<insert id="insert"
		useGeneratedKeys="true"
		keyProperty="id">

		insert into ${ info.artifactId.camel.lowercase }.${ entity.name.plural.snake } (
		<#list entity.fields as field>
			${ field.name }<#sep>,</#sep>
        </#list>
		) VALUES (
		<#list entity.fields as field>
			${r"#{"}${ field.name }${r"}"}<#sep>,</#sep>
        </#list>
		)

	</insert>

	<insert id="update">

		update ${ info.artifactId.camel.lowercase }.${ entity.name.plural.snake }
		<set>
        <#list entity.fields as field>
            <if test="${ field.name } != null">${ field.name } = ${r"#{"} ${ field.name } },</if>
        </#list>
		</set>
		where
			id = ${r"#{"} id }

	</insert>

	<delete id="delete">

		delete from ${ info.artifactId.camel.lowercase }.${ entity.name.plural.snake } where id = ${r"#{id}"}

	</delete>

</mapper>