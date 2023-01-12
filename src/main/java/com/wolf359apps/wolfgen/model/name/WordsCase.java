package com.wolf359apps.wolfgen.model.name;

import com.wolf359apps.wolfgen.util.CaseUtil;

/**
 * 'this is words case'
 */
public class WordsCase extends Name {

    public WordsCase(final String value) {
        super(value);
    }

    @Override
    public Name getPascal() {
        return new PascalCase(CaseUtil.wordsToPascal(value));
    }

    @Override
    public Name getCamel() {
        return new CamelCase(CaseUtil.wordsToCamel(value));
    }

    @Override
    public Name getKebab() {
        return new KebabCase(CaseUtil.wordsToKebab(value));
    }

    @Override
    public Name getSnake() {
        return new SnakeCase(CaseUtil.wordsToSnake(value));
    }

}
