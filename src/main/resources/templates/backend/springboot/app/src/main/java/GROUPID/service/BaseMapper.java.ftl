package ${ info.groupId }.service;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;

@Mapper
public interface BaseMapper<T, ID> {

	List<T> findAll();

	Optional<T> findById(ID id);

	void insert(T t);

	void update(T t);

	void delete(ID id);

	T getRowById(Long id);

}
