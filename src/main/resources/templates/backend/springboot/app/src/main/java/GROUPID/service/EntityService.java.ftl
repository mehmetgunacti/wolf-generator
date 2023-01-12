package ${ info.groupId }.service;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;

@Mapper
public interface EntityService<T, ID> {

	default List<T> findAll() {
		throw new RuntimeException("Method not implemented in service !");
	}

	default Optional<T> findById(ID id) {
		throw new RuntimeException("Method not implemented in service !");
	}

	default T create(T t) {
		throw new RuntimeException("Method not implemented in service !");
	}

	default Optional<T> modify(T t) {
		throw new RuntimeException("Method not implemented in service !");
	}

	default void deleteById(ID id) {
		throw new RuntimeException("Method not implemented in service !");
	}

	default void delete(T t) {
		throw new RuntimeException("Method not implemented in service !");
	}

}
