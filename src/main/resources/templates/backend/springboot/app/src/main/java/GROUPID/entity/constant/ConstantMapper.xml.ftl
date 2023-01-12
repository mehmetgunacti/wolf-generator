<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${ info.groupId }.entity.constant.ConstantMapper">

    <cache/>

    <sql id="baseSQL">
        select
            code,
            name,
            category
        from
            bizimofis.constants
    </sql>

    <select id="findAll"
            resultType="Constant">
        <include refid="baseSQL"/>
    </select>

    <select id="findById"
            resultType="Constant">
        <include refid="baseSQL"/>
        where
            code = ${r"#{code}"}
    </select>

    <insert id="insert">

        insert into bizimofis.constants (
            code,
            name,
            category
        ) values (
            ${r"#{ code }"},
            ${r"#{ name }"},
            ${r"#{ category }"}
        )

    </insert>

    <update id="update">

        update bizimofis.constants
        <set>
            <if test="name != null">name = ${r"#{ name }"},</if>
        </set>
        where
            code = ${r"#{ code }"}

    </update>

    <delete id="delete">

        delete from bizimofis.constants where code = ${r"#{ code }"}

    </delete>

</mapper>