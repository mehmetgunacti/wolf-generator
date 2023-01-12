package com.wolf359apps.wolfgen.model.name;

import java.util.Optional;

/*
 * 'this is space separated'
 */
public class PName {

    private String value;

    public PName(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

}
