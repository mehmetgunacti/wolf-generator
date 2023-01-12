package ${ info.groupId }.entity.${ entity.name.singular };

import ${ info.groupId }.exception.EntityNotFoundException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Service
public class ${ entity.name.singular.pascal }ServiceImpl implements ${ entity.name.singular.pascal }Service {

	private final ${ entity.name.singular.pascal }Mapper ${ entity.name.singular }Mapper;

	/**
	 * Create one ${ entity.name.singular.pascal }.
	 *
	 * @param ${ entity.name.singular } the entity to be created.
	 * @return the created entity.
	 */
	public ${ entity.name.singular.pascal } create(${ entity.name.singular.pascal } ${ entity.name.singular }) {

		${ entity.name.singular }Mapper.insert(${ entity.name.singular });
		return findById(${ entity.name.singular }.getId())
			.orElseThrow(() -> new EntityNotFoundException(${ entity.name.singular }.getId())); // <- unlikely

	}

	/**
		* Modify (update) one or more properties of one ${ entity.name.singular.pascal }.
		*
		* @param ${ entity.name.singular } the entity to be modified.
		* @return the modified entity.
		*/
	@Override
	public Optional<${ entity.name.singular.pascal }> modify(${ entity.name.singular.pascal } ${ entity.name.singular }) {

		${ entity.name.singular }Mapper.update(${ entity.name.singular });
		return findById(${ entity.name.singular }.getId());

	}

	/**
	 * Get all the ${ entity.name.plural.pascal }.
	 *
	 * @return the list of entities.
	 */
	public List<${ entity.name.singular.pascal }> findAll() {

		return ${ entity.name.singular }Mapper.findAll();

	}

	/**
	 * Get the "id" ${ entity.name.singular.pascal }.
	 *
	 * @param "id" the id of the entity.
	 * @return the entity.
	 */
	public Optional<${ entity.name.singular.pascal }> findById(Long id) {

		return ${ entity.name.singular }Mapper.findById(id);

	}

	/**
	 * Delete the "id" ${ entity.name.singular.pascal }.
	 *
	 * @param "id" the id of the entity.
	 */
	@Override
	public void deleteById(Long id) {

		${ entity.name.singular }Mapper.delete(id);

	}

}
