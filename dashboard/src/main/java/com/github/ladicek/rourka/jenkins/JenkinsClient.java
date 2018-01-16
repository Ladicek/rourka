package com.github.ladicek.rourka.jenkins;

import com.github.ladicek.rourka.ConsoleTextResource;
import com.github.ladicek.rourka.ci.BuildStatus;
import com.github.ladicek.rourka.ci.TestCluster;
import com.github.ladicek.rourka.ci.TestDescription;
import com.github.ladicek.rourka.ci.TestResult;
import com.github.ladicek.rourka.ci.TestType;
import com.github.ladicek.rourka.openshift.TokenAuthorizingHttpClient;
import com.google.gson.Gson;
import org.apache.http.HttpResponse;
import org.apache.http.client.fluent.Executor;
import org.apache.http.client.fluent.Request;
import org.apache.http.impl.client.CloseableHttpClient;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.stream.Collectors;

@RequestScoped
public class JenkinsClient {
    @Inject
    @TokenAuthorizingHttpClient
    private CloseableHttpClient httpClient;

    private String jenkinsBaseUrl = "http://jenkins"; // TODO

    public List<Job> getRelevantJobs() throws IOException {
        String url = jenkinsUrl("/api/json?tree=jobs[name,description,lastCompletedBuild[number,timestamp,result],lastBuild[building]]");
        String jsonString = Executor.newInstance(httpClient).execute(Request.Get(url)).returnContent().asString();

        Gson gson = new Gson();
        JsonJobs jobs = gson.fromJson(jsonString, JsonJobs.class);

        return jobs.jobs.stream()
                .filter(it -> it.description != null && !it.description.isEmpty())
                .map(it -> {
                    String description = it.description.replaceAll("<!-- .*? -->", "");
                    JsonJobDataInDescription data = gson.fromJson(description, JsonJobDataInDescription.class);

                    TestResult lastResult;
                    boolean buildingNow = it.lastBuild != null && it.lastBuild.building;
                    if (it.lastCompletedBuild != null) {
                        String link = ConsoleTextResource.link(it.name, it.lastCompletedBuild.number);
                        LocalDateTime timestamp = LocalDateTime.ofInstant(
                                Instant.ofEpochMilli(it.lastCompletedBuild.timestamp), ZoneId.systemDefault());
                        lastResult = new TestResult(BuildStatus.from(it.lastCompletedBuild.result),
                                it.lastCompletedBuild.number, link, timestamp, buildingNow);
                    } else {
                        lastResult = new TestResult(BuildStatus.UNKNOWN, -1, null, null, buildingNow);
                    }

                    return new Job(new TestCluster(data.cluster), new TestDescription(data.description), new TestType(data.type), lastResult);
                })
                .collect(Collectors.toList());
    }

    public ConsoleText streamConsoleText(String buildName, String buildNumber) {
        String url = jenkinsUrl("/job/" + buildName + "/" + buildNumber + "/consoleText");
        return new ConsoleText(httpClient, url);
    }

    // TODO better return type
    public HttpResponse startBuild(String jobName) throws IOException {
        String url = jenkinsUrl("/job/" + jobName + "/build?delay=0sec");
        return Executor.newInstance(httpClient).execute(Request.Get(url)).returnResponse();
    }

    private String jenkinsUrl(String part) {
        String base = jenkinsBaseUrl;
        if (!base.endsWith("/")) {
            base += "/";
        }
        if (part.startsWith("/")) {
            part = part.substring(1);
        }
        return base + part;
    }
}
