<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
		"http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${ info.groupId }.messaging.OnlineMapper">

	<select id="findAll"
			resultType="User">

		select
			u.id,
			u.name,
            u.username
		from
			bizimofis.users u
		where
			u.id in
		<foreach item="item" index="index" collection="ids"
				 open="(" separator="," close=")">
			${r"#{ item }"}
		</foreach>

	</select>

<!--	SELECT EXISTS(SELECT 1 FROM my_table WHERE email= ...) -->
	<select id="isOnline"
			resultType="Boolean">

		select
			1
		where
			fk_users = ${r"#{ id }"}

	</select>

	<insert id="add">

		insert into bizimofis.online (
			fk_users,
			last_ping
		) values (
			${r"#{ id }"},
			${r"#{ lastPing }"}
		)

	</insert>

	<update id="ping">

		update bizimofis.online set
			last_ping = ${r"#{ lastPing }"}
		where
			fk_users = ${r"#{ id }"}

	</update>

	<delete id="remove">

		delete from bizimofis.online where fk_users = ${r"#{ id }"}

	</delete>

</mapper>