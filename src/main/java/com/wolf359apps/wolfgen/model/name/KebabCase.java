package com.wolf359apps.wolfgen.model.name;

import com.wolf359apps.wolfgen.util.CaseUtil;

/**
 * 'this-is-kebab-case'
 */
public class KebabCase extends Name {

    public KebabCase(final String value) {
        super(value);
    }

    @Override
    public Name getPascal() {
        return new PascalCase(CaseUtil.kebabToPascal(value));
    }

    @Override
    public Name getCamel() {
        return new CamelCase(CaseUtil.kebabToCamel(value));
    }

    @Override
    public Name getSnake() {
        return new SnakeCase(CaseUtil.kebabToSnake(value));
    }

    @Override
    public Name getWords() {
        return new WordsCase(CaseUtil.kebabToWords(value));
    }

}
