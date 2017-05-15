package com.github.ladicek.rourka.ci;

import java.time.LocalDateTime;

/**
 * Inner cell of the CI status table.
 */
public final class BuildResult {
    private final BuildStatus status;
    private final String name;
    private final String link;
    private final LocalDateTime timestamp;

    public BuildResult(BuildStatus status, String name, String link, LocalDateTime timestamp) {
        this.status = status;
        this.name = name;
        this.link = link;
        this.timestamp = timestamp;
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

    public LocalDateTime getTimestamp() {
        return timestamp;
    }
}
