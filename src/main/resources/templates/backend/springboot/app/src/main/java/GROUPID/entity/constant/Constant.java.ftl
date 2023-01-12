package ${ info.groupId }.entity.constant;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class Constant implements Serializable {

	protected String code;
	protected String name;
	protected String category;

	public Constant(String code) {

		this.code = code;

	}

	@Override
	public int hashCode() {

		return this.code.hashCode();

	}

	@Override
	public boolean equals(Object obj) {

		if ( obj == null || code == null )
			return false;

		if ( obj instanceof Constant)
			return ( (Constant) obj ).getCode().equals( code );

		return false;

	}

}

