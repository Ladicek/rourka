package com.github.ladicek.rourka.ci;

import java.util.Objects;

/**
 * Column of the CI status table.
 */
public final class TestType {
    private final String value;

    public TestType(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof TestType)) return false;
        TestType that = (TestType) o;
        return Objects.equals(value, that.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value);
    }
}
