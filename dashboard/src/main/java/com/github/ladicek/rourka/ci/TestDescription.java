package com.github.ladicek.rourka.ci;

import java.util.Objects;

/**
 * Row of the CI status table.
 */
public final class TestDescription {
    private final String value;

    public TestDescription(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof TestDescription)) return false;
        TestDescription that = (TestDescription) o;
        return Objects.equals(value, that.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value);
    }
}
