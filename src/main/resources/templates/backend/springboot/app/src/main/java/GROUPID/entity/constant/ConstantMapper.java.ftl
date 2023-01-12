package ${ info.groupId }.entity.constant;

import ${ info.groupId }.service.BaseMapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
interface ConstantMapper extends BaseMapper<Constant, String> { }
