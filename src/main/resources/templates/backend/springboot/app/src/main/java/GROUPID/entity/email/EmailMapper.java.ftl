package ${ info.groupId }.entity.email;

import ${ info.groupId }.constant.EmailType;
import ${ info.groupId }.entity.BaseEntity;
import ${ info.groupId }.service.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.Instant;
import java.util.List;

@Mapper
public interface EmailMapper extends BaseMapper<Email, Long> {

	List<Email> findOutgoing(@Param("maxRetry") Integer maxRetry);

	List<BaseEntity> findRecipients(Long id);

	Email find(@Param("type") EmailType type, @Param("now") Instant now);

	void insertRecipients(@Param("userId") Long userId, @Param("emailId") Long emailId);

	void updateSent(@Param("id") Long id, @Param("now") Instant now);

	void increaseRetry(Long id);

}
