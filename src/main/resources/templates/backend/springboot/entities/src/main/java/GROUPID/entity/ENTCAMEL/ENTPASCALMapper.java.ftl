package ${ info.groupId }.entity.${ entity.name.singular };

import ${ info.groupId }.service.BaseMapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
interface ${ entity.name.singular.pascal }Mapper extends BaseMapper<${ entity.name.singular.pascal }, Long> { }
