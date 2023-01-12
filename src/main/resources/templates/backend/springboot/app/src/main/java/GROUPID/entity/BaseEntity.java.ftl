package ${ info.groupId }.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;
import java.time.Instant;

@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class BaseEntity implements Serializable {

	protected Long id;
	protected Instant created;
	protected Instant modified;

	@Override
	public boolean equals(Object obj) {

		if (obj == null || id == null)
			return false;

		if (obj instanceof BaseEntity)
			return ((BaseEntity) obj).getId().equals(id);

		return false;

	}

	@Override
	public int hashCode() {

		return id == null ? super.hashCode() : id.hashCode();

	}

}
