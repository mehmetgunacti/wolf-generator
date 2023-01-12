package com.wolf359apps.wolfgen.model.name;

import com.wolf359apps.wolfgen.util.CaseUtil;

/**
 * 'thisIsCamelCase'
 */
public class CamelCase extends Name {

    public CamelCase(final String value) {
        super(value);
    }

    @Override
    public Name getPascal() {
        return new PascalCase(CaseUtil.camelToPascal(value));
    }

    @Override
    public Name getKebab() {
        return new KebabCase(CaseUtil.camelToKebab(value));
    }

    @Override
    public Name getSnake() {
        return new SnakeCase(CaseUtil.camelToSnake(value));
    }

    @Override
    public Name getWords() {
        return new WordsCase(CaseUtil.camelToWords(value));
    }

}
