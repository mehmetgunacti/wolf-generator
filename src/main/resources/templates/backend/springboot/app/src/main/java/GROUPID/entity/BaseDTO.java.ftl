package ${ info.groupId }.entity;

import ${ info.groupId }.constant.EntityNames;
import lombok.Getter;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public abstract class BaseDTO {

    @Getter
    private final Map<EntityNames, EntityDTO> data;

    protected BaseDTO(Map<EntityNames, EntityDTO> data) {

        this.data = data;

    }

    public static class EntityDTO {

        private final List<? extends BaseEntity> entityList;

        @Getter
        private final Map<Long, ? extends BaseEntity> entities;

        @Getter
        private final Long[] ids;

        public EntityDTO(List<? extends BaseEntity> entityList) {

            this.entityList = entityList;
            this.entities = this.entityList.stream().collect(Collectors.toMap(
                    BaseEntity::getId,
                    entity -> entity
            ));
            this.ids = entityList
                    .stream()
                    .map(BaseEntity::getId)
                    .collect(Collectors.toList())
                    .toArray(Long[]::new);

        }

        public EntityDTO(Long id) {

            this.entityList = Collections.emptyList();

            Map<Long, ? extends BaseEntity> map = new HashMap<>();
            map.put(id, null);
            this.entities = map;
            this.ids = new Long[] {id};

        }

    }

}