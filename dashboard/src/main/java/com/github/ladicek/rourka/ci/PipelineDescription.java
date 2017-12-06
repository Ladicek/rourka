package com.github.ladicek.rourka.ci;

import java.util.Objects;

/**
 * Row of the CI status table.
 */
public final class PipelineDescription {
    private final String value;

    public PipelineDescription(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof PipelineDescription)) return false;
        PipelineDescription that = (PipelineDescription) o;
        return Objects.equals(value, that.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value);
    }
}
