package com.github.ladicek.rourka.ci;

import java.time.LocalDateTime;

/**
 * Inner cell of the CI status table.
 */
public final class BuildResult {
    private final BuildStatus status;
    private final String link;
    private final LocalDateTime timestamp;
    private int buildNumber;

    public BuildResult(BuildStatus status, int buildNumber, String link, LocalDateTime timestamp) {
        this.status = status;
        this.link = link;
        this.timestamp = timestamp;
        this.buildNumber= buildNumber;
    }

    public BuildStatus getStatus() {
        return status;
    }

    public int getBuildNumber() {
        return buildNumber;
    }

    public String getLink() {
        return link;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public String toString()
    {
        return "Build Status: " + status
                + ", buildNumber: " + buildNumber
                + ", link: " + link
                + ", timestamp: " + timestamp;
    }
}
