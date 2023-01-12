package com.wolf359apps.wolfgen.constants;

public enum FieldType {
    number,
    text,
    password,
    timestamp,
    money,
    phone,
    email,
    bool,
    date;

    public String getJava() {

        return switch (this) {

            case number -> "Integer";
            case text, email, password, phone -> "String";
            case timestamp -> "Instant";
            case money -> "Double";
            case bool -> "Boolean";
            case date -> "LocalDate";

        };

    }

    public String getMysql(Integer max) {

        return switch (this) {

            case number -> "INT";
            case text, email, phone -> "VARCHAR(%s)".formatted(max);
            case password -> "VARCHAR(100)";
            case timestamp -> "TIMESTAMP";
            case money -> "DECIMAL(13, 2)";
            case bool -> "BIT(1)";
            case date -> "DATE";

        };

    }

    public String getTypescript() {

        return switch (this) {

            case number,
                    money -> "number";
            case text, email, password, phone -> "string";
            case timestamp,
                    date -> "Date";
            case bool -> "boolean";

        };

    }

}
