package com.github.ladicek.rourka.ci;

import io.fabric8.openshift.api.model.Build;

import javax.json.Json;
import javax.json.JsonObject;
import java.io.StringReader;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Inner cell of the CI status table.
 */
public final class BuildResult {
    private final BuildStatus status;
    private final String name;
    private final String link;
    private final LocalDateTime timestamp;

    public static BuildResult from(Build build) {
        BuildStatus status;
        String statusJsonString = build.getMetadata().getAnnotations().get("openshift.io/jenkins-status-json");
        JsonObject statusJson = Json.createReader(new StringReader(statusJsonString)).readObject();
        String statusString = statusJson.getString("status");
        switch (statusString) {
            case "SUCCESS":
                status = BuildStatus.PASS;
                break;
            case "FAILED":
                status = BuildStatus.FAIL;
                break;
            default:
                status = BuildStatus.UNKNOWN;
        }
        String name = statusJson.getString("name");
        String link = "/console-text/" + build.getMetadata().getName();
        LocalDateTime timestamp = null;
        try {
            timestamp = LocalDateTime.parse(build.getStatus().getCompletionTimestamp(), DateTimeFormatter.ISO_OFFSET_DATE_TIME);
        } catch (Exception e) {
        }
        return new BuildResult(status, name, link, timestamp);
    }

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
