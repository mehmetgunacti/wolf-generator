package ${ info.groupId }.util;

import ${ info.groupId }.constant.Category;
import ${ info.groupId }.exception.E400BadRequestException;
import lombok.Getter;

public class StringValidator {

    @Getter
    private String value;

    private StringValidator(String value) {
        this.value = value;
    }

    public static StringValidator getInstance(String value) {
        if (value == null)
            throw new E400BadRequestException();

        return new StringValidator(value);
    }

    public static StringValidator trim(String value) {
        if (value == null)
            throw new E400BadRequestException();

        return new StringValidator(value.trim());
    }


    public StringValidator andIsOfLength(int length) {
        if (value.length() != length)
            throw new E400BadRequestException();

        return this;
    }

    public StringValidator andIsOfType(Category sabit) {
        if (value.length() != 4)
            throw new E400BadRequestException();

        try {
            Integer.parseInt(value.substring(1));
        } catch (NumberFormatException nfe) {
            throw new E400BadRequestException();
        }

        if (value.startsWith(sabit.getCategoryType().substring(0, 1)))
            return this;

        throw new E400BadRequestException();
    }

    public StringValidator trim() {
        this.value = this.value.trim();
        return this;
    }

    public StringValidator andLengthIsBetween(int min, int max) {
        int length = value.length();

        if (length < min || length > max)
            throw new E400BadRequestException();

        return this;
    }
}
