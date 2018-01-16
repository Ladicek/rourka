package com.github.ladicek.rourka.jenkins;

import java.util.List;

class JsonJobs {
    List<JsonJob> jobs;

    static class JsonJob {
        String name;
        String description;
        JsonLastCompletedBuild lastCompletedBuild;
        JsonLastBuild lastBuild;

        boolean isRelevant() {
            return description != null && !description.isEmpty();
        }
    }

    static class JsonLastCompletedBuild {
        int number;
        long timestamp;
        String result;
    }

    static class JsonLastBuild {
        boolean building;
    }
}
