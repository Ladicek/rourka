package com.github.ladicek.rourka.ci;

import java.util.Objects;

/**
 * Column of the CI status table.
 */
public final class PipelineType {
    private final String value;

    public PipelineType(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof PipelineType)) return false;
        PipelineType that = (PipelineType) o;
        return Objects.equals(value, that.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value);
    }
}
