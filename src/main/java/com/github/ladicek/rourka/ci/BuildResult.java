package com.github.ladicek.rourka.ci;

/**
 * Inner cell of the CI status table.
 */
public final class BuildResult {
    private final BuildStatus status;
    private final String name;
    private final String link;

    public BuildResult(BuildStatus status, String name, String link) {
        this.status = status;
        this.name = name;
        this.link = link;
    }

    public BuildStatus getStatus() {
        return status;
    }

    public String getName() {
        return name;
    }

    public String getLink() {
        return link;
    }
}
