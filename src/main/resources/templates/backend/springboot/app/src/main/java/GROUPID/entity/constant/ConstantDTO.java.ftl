package ${ info.groupId }.entity.constant;

import ${ info.groupId }.constant.EntityNames;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Getter
public class ConstantDTO {
    @Getter
    private final Map<EntityNames, ConstantDTO.EntityDTO> data;

    protected ConstantDTO(List<Constant> constants) {

        this.data = Map.of(
                EntityNames.constants, new ConstantDTO.EntityDTO(constants)
        );

    }

    public ConstantDTO(Constant constant) {

        this(Collections.singletonList(constant));

    }

    public ConstantDTO(String code) {

        this.data = Map.of(EntityNames.constants, new EntityDTO(code));

    }

    private static class EntityDTO {

        private final List<Constant> entityList;

        @Getter
        private final Map<String, Constant> entities;

        @Getter
        private final String[] ids;

        public EntityDTO(List<Constant> entityList) {

            this.entityList = entityList;
            this.entities = this.entityList.stream().collect(Collectors.toMap(
                    Constant::getCode,
                    entity -> entity
            ));
            this.ids = entityList
                    .stream()
                    .map(Constant::getCode)
                    .collect(Collectors.toList())
                    .toArray(String[]::new);

        }

        // constructor for empty dtos
        public EntityDTO(String code) {

            this.entityList = Collections.emptyList();

            Map<String, Constant> map = new HashMap<>();
            map.put(code, null);
            this.entities = map;
            this.ids = new String[]{code};

        }

    }

}
