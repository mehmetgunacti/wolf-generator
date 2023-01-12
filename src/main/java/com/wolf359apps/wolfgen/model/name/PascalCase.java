package com.wolf359apps.wolfgen.model.name;

import com.wolf359apps.wolfgen.util.CaseUtil;

/**
 * 'ThisIsPascalCase'
 */
public class PascalCase extends Name {

    public PascalCase(final String value) {
        super(value);
    }

    @Override
    public Name getCamel() {
        return new CamelCase(CaseUtil.pascalToCamel(value));
    }

    @Override
    public Name getKebab() {
        return new KebabCase(CaseUtil.pascalToKebab(value));
    }

    @Override
    public Name getSnake() {
        return new SnakeCase(CaseUtil.pascalToSnake(value));
    }

    @Override
    public Name getWords() {
        return new WordsCase(CaseUtil.pascalToWords(value));
    }

}
