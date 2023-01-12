<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
		"http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${ info.groupId }.entity.auth.AuthMapper">

	<insert id="grantRole">

		insert into bizimofis.roles (
			fk_users,
			role
		) values (
			${r"#{ userId }"},
			${r"#{ role }"}
		)

	</insert>

	<delete id="revokeRole">

		delete from
			bizimofis.roles
		where
			fk_users = ${r"#{ userId }"}
			and role = ${r"#{ role }"}

	</delete>

    <update id="remindPassword">

        update bizimofis.users set
            password = ${r"#{ password }"},
            password_expiration = ${r"#{ passwordExpiration }"}
        where
            id = ${r"#{ id }"}

    </update>

    <update id="changePassword">

        update bizimofis.users set
            password = ${r"#{ password }"},
            password_expiration = ${r"#{ passwordExpiration }"}
        where
            username = ${r"#{ username }"}

    </update>

	<update id="disableAccount">

		update
			bizimofis.users
		set
			account_expiration = null
		where
			id = ${r"#{ userId }"}

	</update>

</mapper>