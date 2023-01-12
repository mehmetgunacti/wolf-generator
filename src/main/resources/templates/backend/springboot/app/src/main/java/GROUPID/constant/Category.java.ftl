package ${ info.groupId }.constant;

import ${ info.groupId }.entity.constant.Constant;

import lombok.Getter;

public enum Category {

	COUNTRY("C"),
	COUNTY("D"),
	EMAIL_TYPE("N"),
	INSTANT_FILE("F");

	@Getter
	private String categoryType;

	Category(String categoryType) {

		this.categoryType = categoryType;

	}

	public Constant create(String value) {

		return new Constant(categoryType + value);

	}

}
