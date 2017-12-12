package com.github.ladicek.rourka.jenkins;

import com.github.ladicek.rourka.ci.BuildResult;
import com.github.ladicek.rourka.ci.Cluster;
import com.github.ladicek.rourka.ci.PipelineDescription;
import com.github.ladicek.rourka.ci.PipelineType;

public class Job {

    private String jobClass;
    private String name;
    private String url;
    private String color;

    private PipelineDescription description;
    private PipelineType type;
    private Cluster cluster;
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

    public BuildResult getLastBuildResult() {
        return lastBuildResult;
    }

    public void setLastBuildResult(BuildResult lastBuildResult) {
        this.lastBuildResult = lastBuildResult;
    }

    public PipelineDescription getDescription() {
        return description;
    }

    public void setDescription(PipelineDescription description) {
        this.description = description;
    }

    public PipelineType getType() {
        return type;
    }

    public void setType(PipelineType type) {
        this.type = type;
    }

    public Cluster getCluster() {
        return cluster;
    }

    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }

    public String toString(){
        return "class: " + jobClass
                + ", name: " + name
                + ", url: " + url
                + ", color: " + color
                + ", description: " + description
                + ", type: " + type
                + ", cluster: " + cluster
                + ", last build result: " + lastBuildResult;
    }
}
