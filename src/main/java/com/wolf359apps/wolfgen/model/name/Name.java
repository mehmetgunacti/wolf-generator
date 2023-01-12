package com.wolf359apps.wolfgen.model.name;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;

import java.util.Optional;

/*
 * 'this is space separated'
 */
public abstract class Name {

    protected String value;

    public Name(final String value) {

        this.value = Optional
                .ofNullable(value)
                .filter(StringUtils::isNotBlank)
                .orElseThrow(IllegalArgumentException::new);

    }

    @Override
    public String toString() {

        return value;

    }

    public Name getPascal() {
        return this;
    }

    public Name getCamel() {
        return this;
    }

    public Name getKebab() {
        return this;
    }

    public Name getSnake() {
        return this;
    }

    public Name getWords() {
        return this;
    }

    public Name getUppercase() {

        value = value.toUpperCase();
        return this;

    }

    public Name getLowercase() {

        value = value.toLowerCase();
        return this;

    }

}
