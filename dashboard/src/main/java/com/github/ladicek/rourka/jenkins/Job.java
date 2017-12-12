package com.github.ladicek.rourka.jenkins;

import com.github.ladicek.rourka.ci.BuildResult;

public class Job {

    private String jobClass;
    private String name;
    private String url;
    private String color;

    private String description;
    private BuildResult lastBuildResult;

    public Job(String jobClass, String name, String url, String color) {
        this.jobClass = jobClass;
        this.name = name;
        this.url = url;
        this.color = color;
    }

    public String getJobClass() {
        return jobClass;
    }

    public String getName() {
        return name;
    }

    public String getUrl() {
        return url;
    }

    public String getColor() {
        return color;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BuildResult getLastBuildResult() {
        return lastBuildResult;
    }

    public void setLastBuildResult(BuildResult lastBuildResult) {
        this.lastBuildResult = lastBuildResult;
    }

    public String toString(){
        return "class: " + jobClass
                + ", name: " + name
                + ", url: " + url
                + ", color: " + color
                + ", description: " + description
                + ", last build result: " + lastBuildResult;
    }
}
