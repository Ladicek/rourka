package com.github.ladicek.rourka.ci;

import java.util.Objects;

/**
 * Name of one of the CI status tables. Corresponds to an OpenShift cluster on which the tests are executed.
 */
public final class TestCluster {
    private final String value;

    public TestCluster(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof TestCluster)) return false;
        TestCluster that = (TestCluster) o;
        return Objects.equals(value, that.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value);
    }
}
