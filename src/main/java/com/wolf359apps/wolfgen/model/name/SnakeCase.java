package com.wolf359apps.wolfgen.model.name;

import com.wolf359apps.wolfgen.util.CaseUtil;

/**
 * 'this_is_snake_case'
 */
public class SnakeCase extends Name {

    public SnakeCase(final String value) {
        super(value);
    }

    @Override
    public Name getPascal() {
        return new PascalCase(CaseUtil.snakeToPascal(value));
    }

    @Override
    public Name getCamel() {
        return new CamelCase(CaseUtil.snakeToCamel(value));
    }

    @Override
    public Name getKebab() {
        return new KebabCase(CaseUtil.snakeToKebab(value));
    }

    @Override
    public Name getWords() {
        return new WordsCase(CaseUtil.snakeToWords(value));
    }

}
