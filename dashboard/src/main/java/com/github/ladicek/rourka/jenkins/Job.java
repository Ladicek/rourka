package com.github.ladicek.rourka.jenkins;

import com.github.ladicek.rourka.ci.TestCluster;
import com.github.ladicek.rourka.ci.TestDescription;
import com.github.ladicek.rourka.ci.TestResult;
import com.github.ladicek.rourka.ci.TestType;

public final class Job {
    private final TestCluster cluster;
    private final TestDescription description;
    private final TestType type;
    private final TestResult lastResult;

    Job(TestCluster cluster, TestDescription description, TestType type, TestResult lastResult) {
        this.cluster = cluster;
        this.description = description;
        this.type = type;
        this.lastResult = lastResult;
    }

    public TestCluster getCluster() {
        return cluster;
    }

    public TestDescription getDescription() {
        return description;
    }

    public TestType getType() {
        return type;
    }

    public TestResult getLastResult() {
        return lastResult;
    }
}
