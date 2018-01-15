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
    private Boolean building; //is the build running right now

    public BuildResult(BuildStatus status, int buildNumber, String link, Boolean building, LocalDateTime timestamp) {
        this.status = status;
        this.link = link;
        this.building=building;
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


    public Boolean isBuilding() {
        if (building == null){
            return false;
        }
        return building;
    }

    public String toString()
    {
        return "Build Status: " + status
                + ", buildNumber: " + buildNumber
                + ", link: " + link
                + ", building: " + building
                + ", timestamp: " + timestamp;
    }
}
