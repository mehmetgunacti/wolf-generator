package com.wolf359apps.wolfgen.model;

import com.wolf359apps.wolfgen.constants.FieldType;
import com.wolf359apps.wolfgen.exception.InvalidConfigurationException;
import com.wolf359apps.wolfgen.model.name.CamelCase;
import com.wolf359apps.wolfgen.model.name.Name;
import com.wolf359apps.wolfgen.model.name.PName;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Optional;

@Getter
@Setter
public class App {

	private Info         info;
	private List<Entity> entities;

	@Getter
	@Setter
	@ToString
	public static class Info {

		private Name   artifactId;
		private String groupId;
		private String title;
		private String description;

	}

	@Getter
	@Setter
	@ToString
	public static class Entity {

		private EntityName         name;
		private String             schema;
		private List<Entity.Field> fields;

		@Getter
		@Setter
		@ToString
		public static class Field {

			private CamelCase name;
			private FieldType type;
			private String    java;
			private String    typescript;
			private String    mysql;
			private boolean   required;
			private Integer   max;
			private Integer   min;
			private Object    defaultValue;

			public Field() {

				this.max = 255;
				this.required = false;

			}

			public String getJava() {

				if (java != null)
					return java;

				if (type == null)
					throw new InvalidConfigurationException("Neither 'template' nor 'java' fields are set.");

				return type.getJava();

			}

			public String getTypescript() {

				if (typescript != null)
					return typescript;

				if (type == null)
					throw new InvalidConfigurationException("Neither 'template' nor 'typescript' fields are set.");

				return type.getTypescript();

			}

			public String getMysql() {

				if (mysql != null)
					return mysql;

				if (type == null)
					throw new InvalidConfigurationException("Neither 'template' nor 'mysql' fields are set.");

				return type.getMysql(255); // max

			}

		}

		@Getter
		@Setter
		public static class EntityName {

			private Name singular; // todo convert this to Name, also generate setter & constructor and see which one is called by SnakeYaml
			private Name plural;

			public void setSingular(String value) {

				this.singular = new CamelCase(value);

			}

			public void setPlural(String value) {

				Optional.ofNullable(value)
						.filter(StringUtils::isNotBlank)
						.ifPresent(v -> this.plural = new CamelCase(v));

			}

			public Name getPlural() {

				return plural == null ? singular : plural;

			}

		}

	}

	@Getter
	@Setter
	@ToString
	public static class Category {

		private List<Code> codes;

		@Getter
		@Setter
		@ToString
		public static class Code {

			private String code;
			private String name;

		}

	}

}