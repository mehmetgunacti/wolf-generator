<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
		"http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${ info.groupId }.entity.email.EmailMapper">

	<sql id="baseSQL">

		select
			e.id,
			e.email_type as 'emailType.id',
			e.subject,
			e.content,
		  	e.created,
  			e.sent,
  			e.retry
		from
			bizimofis.emails e

	</sql>

	<select id="findOutgoing"
			resultType="Email">

		<include refid="baseSQL"/>
		where
			e.retry <![CDATA[<]]> ${r"#{maxRetry}"} and
			e.sent is null
		order by
			e.id

	</select>

	<select id="find"
			resultType="Email">

		<include refid="baseSQL"/>
		where
			e.email_type = ${r"#{emailType.id}"} and
			e.created > ${r"#{now}"}

	</select>

	<insert id="insert"
			useGeneratedKeys="true"
			keyProperty="id">

		insert into bizimofis.emails (
			email_type,
			subject,
			content,
			created,
			retry
		) values (
			${r"#{emailType.id}"},
			${r"#{subject}"},
			${r"#{content}"},
			${r"#{created}"},
			${r"#{retry}"}
		)

	</insert>


	<select id="findRecipients"
		    resultType="User">

		select
			u.username
		from
			bizimofis.email_recipients er
		inner join
			bizimofis.users u
		on
			u.id = er.fk_users
		where
			er.fk_emails = ${r"#{id}"}

	</select>

	<insert id="insertRecipients">

		insert into bizimofis.email_recipients (
			fk_users,
			fk_emails
		) value (
			${r"#{userId}"},
			${r"#{emailId}"}
		)

	</insert>

	<update id="updateSent">

		update bizimofis.emails set sent = ${r"#{now}"} where id = ${r"#{id}"}

	</update>

	<update id="increaseRetry">

		update bizimofis.emails set retry = retry + 1 where id = ${r"#{id}"}

	</update>

</mapper>