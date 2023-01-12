package ${ info.groupId }.entity.${ entity.name.singular };

import ${ info.groupId }.constant.EntityNames;
import ${ info.groupId }.entity.BaseDTO;

import java.util.Collections;
import java.util.List;
import java.util.Map;

public class ${ entity.name.singular.pascal }DTO extends BaseDTO {

    public ${ entity.name.singular.pascal }DTO(List<${ entity.name.singular.pascal }> entities) {

        super(
                Map.of(
                        EntityNames.${ entity.name.plural }, new EntityDTO(entities)
                )
        );

    }

    public ${ entity.name.singular.pascal }DTO(${ entity.name.singular.pascal } ${ entity.name.singular }) {

        this(Collections.singletonList(${ entity.name.singular }));

    }

    // constructor for empty DTO == EntityNotFoundException
    public ${ entity.name.singular.pascal }DTO(Long id) {

        super(
                Map.of(
                        EntityNames.${ entity.name.plural }, new EntityDTO(id)
                )
        );

    }

}
