package com.github.ladicek.rourka.ci;

import java.util.Objects;

abstract public class AbstractValueTrasfer {
    protected final String value;
    private final String emptyValue="Unspecified";

    protected AbstractValueTrasfer(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        if(value == null || value.equals("")){
            return emptyValue;
        }
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof AbstractValueTrasfer)) return false;
        AbstractValueTrasfer that = (AbstractValueTrasfer) o;
        return Objects.equals(value, that.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value);
    }
}
