<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
		"http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${ info.groupId }.entity.auth.AuthUserMapper">

	<sql id="baseSelect">

		select
			u.id,
			u.name,
			u.title,
			u.birthdate,
			u.mobile,
			u.phone,
			u.username,
			u.password,
			u.password_expiration,
			u.password_attempts,
			u.account_expiration,
			u.last_login
		from bizimofis.users u

	</sql>

	<select id="findByUsername"
			resultType="AuthUser">

		<include refid="baseSelect"/>
		where
			u.username = ${r"#{ username }"}

	</select>

	<select id="findById"
			resultType="AuthUser">

		<include refid="baseSelect"/>
		where
			u.id = ${r"#{ id }"}

	</select>

	<select id="findAll"
			resultType="AuthUser">

		<include refid="baseSelect"/>
		where
			u.username &lt;&gt; 'admin'

	</select>

	<select id="findRolesByUserId"
			resultType="String">

		select
			role
		from
			bizimofis.roles
		where
			fk_users = ${r"#{ userId }"}

	</select>

	<select id="findByRole"
			resultType="AuthUser">

		<include refid="baseSelect"/>
		inner join
			bizimofis.roles r
		on
			u.id = r.fk_users

		where
			r.fk_role = ${r"#{ role }"}

	</select>

	<insert id="insert"
			useGeneratedKeys="true"
			keyProperty="id">

		insert into bizimofis.users (
			name,
			birthdate,
			title,
			mobile,
			phone,
			username,
			password,
			password_expiration,
			password_attempts,
			account_expiration,
			last_login
		) VALUES (
			${r"#{ name }"},
			${r"#{ birthdate }"},
			${r"#{ title }"},
			${r"#{ mobile }"},
			${r"#{ phone }"},
			${r"#{ username }"},
			${r"#{ password }"},
			${r"#{ passwordExpiration }"},
			${r"#{ passwordAttempts }"},
			${r"#{ accountExpiration }"},
			${r"#{ lastLogin }"}
		)

	</insert>

	<update id="update">

        update bizimofis.users
        <set>
            <if test="name != null">name = ${r"#{ name }"},</if>
            <if test="title != null">title = ${r"#{ title }"},</if>
            <if test="birthdate != null">birthdate = ${r"#{ birthdate }"},</if>
            <if test="mobile != null">mobile = ${r"#{ mobile }"},</if>
            <if test="phone != null">phone = ${r"#{ phone }"},</if>
            <if test="username != null">username = ${r"#{ username }"},</if>
            <if test="password != null">password = ${r"#{ password }"},</if>
			<if test="passwordExpiration != null">password_expiration = ${r"#{ passwordExpiration }"},</if>
			<if test="passwordAttempts != null">password_attempts = ${r"#{ passwordAttempts }"},</if>
            <if test="accountExpiration != null">account_expiration = ${r"#{ accountExpiration }"},</if>
            <if test="lastLogin != null">last_login = ${r"#{ lastLogin }"},</if>
        </set>
        where
            id = ${r"#{ id }"}

	</update>

	<delete id="delete">

		delete from bizimofis.users where id = ${r"#{ id }"}

	</delete>

</mapper>