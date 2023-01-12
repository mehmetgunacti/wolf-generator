package com.wolf359apps.wolfgen.util;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.text.CaseUtils;
import org.apache.commons.text.WordUtils;

import java.util.Optional;

public class CaseUtil {

	private static final char SPACE      = ' ';
	private static final char HYPHEN     = '-';
	private static final char UNDERSCORE = '_';
	private static final char DOT        = '.';

	/**
	 * 'thisIsCamelCase' -> 'ThisIsPascalCase'
	 */
	public static String camelToPascal(String value) {

		return WordUtils.capitalize(value);

	}

	/**
	 * 'thisIsCamelCase' -> 'this-is-kebab-case'
	 */
	public static String camelToKebab(String value) {

		return camelTo(value, HYPHEN);

	}

	/**
	 * 'thisIsCamelCase' -> 'this_is_snake_case'
	 */
	public static String camelToSnake(String value) {

		return camelTo(value, UNDERSCORE);

	}

	/**
	 * 'thisIsCamelCase' -> 'this is words case'
	 */
	public static String camelToWords(String value) {

		return camelTo(value, SPACE);

	}

	private static String camelTo(String camel, char separator) {

		final StringBuilder result        = new StringBuilder();
		boolean             lastUppercase = false;

		for (int i = 0; i < camel.length(); i++) {

			char ch        = camel.charAt(i);
			char lastEntry = i == 0 ? 'X' : result.charAt(result.length() - 1);
			if (ch == SPACE || ch == UNDERSCORE || ch == HYPHEN || ch == DOT) {

				lastUppercase = false;
				if (lastEntry == separator)
					continue;
				else
					ch = separator;

			} else if (Character.isUpperCase(ch)) {

				ch = Character.toLowerCase(ch);
				// is start?
				if (i > 0) {
					if (lastUppercase) {
						// test if end of acronym
						if (i + 1 < camel.length()) {

							char next = camel.charAt(i + 1);
							if (!Character.isUpperCase(next) && Character.isAlphabetic(next))
								// end of acronym
								if (lastEntry != separator)
									result.append(separator);

						}

					} else {

						// last was lowercase, insert separator
						if (lastEntry != separator)
							result.append(separator);

					}

				}
				lastUppercase = true;

			} else
				lastUppercase = false;

			result.append(ch);

		}
		return result.toString();

	}

	/**
	 * 'this-is-kebab-case' -> 'ThisIsPascalCase'
	 */
	public static String kebabToPascal(String value) {

		return CaseUtils.toCamelCase(value, true, HYPHEN);

	}

	/**
	 * 'this-is-kebab-case' -> 'thisIsCamelCase'
	 */
	public static String kebabToCamel(String value) {

		return CaseUtils.toCamelCase(value, false, HYPHEN);

	}

	/**
	 * 'this-is-kebab-case' -> 'this_is_snake_case'
	 */
	public static String kebabToSnake(String value) {

		return Optional
				.ofNullable(value)
				.filter(StringUtils::isNotBlank)
				.map(v -> v.replace(HYPHEN, UNDERSCORE))
				.orElse(value);

	}

	/**
	 * 'this-is-kebab-case' -> 'this is words case'
	 */
	public static String kebabToWords(String value) {

		return Optional
				.ofNullable(value)
				.filter(StringUtils::isNotBlank)
				.map(v -> v.replace(HYPHEN, SPACE))
				.orElse(value);

	}

	/**
	 * 'ThisIsPascalCase' -> 'thisIsCamelCase'
	 */
	public static String pascalToCamel(String value) {

		return StringUtils.uncapitalize(value);

	}

	/**
	 * 'ThisIsPascalCase' -> 'this-is-kebab-case'
	 */
	public static String pascalToKebab(String value) {

		return camelTo(pascalToCamel(value), HYPHEN);

	}

	/**
	 * 'ThisIsPascalCase' -> 'this_is_snake_case'
	 */
	public static String pascalToSnake(String value) {

		return camelTo(pascalToCamel(value), UNDERSCORE);

	}

	/**
	 * 'ThisIsPascalCase' -> 'this is words case'
	 */
	public static String pascalToWords(String value) {

		return camelTo(pascalToCamel(value), SPACE);

	}

	/**
	 * 'this_is_snake_case' -> 'ThisIsPascalCase'
	 */
	public static String snakeToPascal(String value) {

		return CaseUtils.toCamelCase(value, true, UNDERSCORE);

	}

	/**
	 * 'this_is_snake_case' -> 'thisIsCamelCase'
	 */
	public static String snakeToCamel(String value) {

		return CaseUtils.toCamelCase(value, false, UNDERSCORE);

	}

	/**
	 * 'this_is_snake_case' -> 'this-is-kebab-case'
	 */
	public static String snakeToKebab(String value) {

		return Optional
				.ofNullable(value)
				.filter(StringUtils::isNotBlank)
				.map(v -> v.replace(UNDERSCORE, HYPHEN))
				.orElse(value);

	}

	/**
	 * 'this_is_snake_case' -> 'this is words case'
	 */
	public static String snakeToWords(String value) {

		return Optional
				.ofNullable(value)
				.filter(StringUtils::isNotBlank)
				.map(v -> v.replace(UNDERSCORE, SPACE))
				.orElse(value);

	}

	/**
	 * 'this is words case' -> 'ThisIsPascalCase'
	 */
	public static String wordsToPascal(String value) {

		return CaseUtils.toCamelCase(value, true, SPACE);

	}

	/**
	 * 'this is words case' -> 'thisIsCamelCase'
	 */
	public static String wordsToCamel(String value) {

		return CaseUtils.toCamelCase(value, false, SPACE);

	}

	/**
	 * 'this is words case' -> 'this-is-kebab-case'
	 */
	public static String wordsToKebab(String value) {

		return Optional
				.ofNullable(value)
				.filter(StringUtils::isNotBlank)
				.map(v -> v.replace(SPACE, HYPHEN))
				.orElse(value);

	}

	/**
	 * 'this is words case' -> 'this_is_snake_case'
	 */
	public static String wordsToSnake(String value) {

		return Optional
				.ofNullable(value)
				.filter(StringUtils::isNotBlank)
				.map(v -> v.replace(SPACE, UNDERSCORE))
				.orElse(value);

	}

}
