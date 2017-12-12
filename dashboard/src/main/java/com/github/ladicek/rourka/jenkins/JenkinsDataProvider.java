package com.github.ladicek.rourka.jenkins;

import com.github.ladicek.rourka.ci.BuildResult;
import com.github.ladicek.rourka.ci.BuildStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.fluent.Executor;
import org.apache.http.client.fluent.Request;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.json.JsonValue;
import java.io.IOException;
import java.io.StringReader;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

public class JenkinsDataProvider {

    private Executor executor;

    public JenkinsDataProvider(HttpClient httpClient){
        executor = Executor.newInstance(httpClient);
    }

    /**
     * List all jobs (builds) in jenkins and their last build results
     * @return List of all jobs
     * @throws IOException If connection to jenkins fails
     */
    public List<Job> getJobs() throws IOException {

        // get jobs from jenkins
        JsonObject page= getJsonApiPage("http://jenkins");
        JsonArray jsonJobs = page.getJsonArray("jobs");

        List<Job> jobs=new ArrayList<>();
        // parse json into job objects
        for (JsonValue jsonValue: jsonJobs)
        {
            JsonObject jsonJobObject=(JsonObject) jsonValue;

            Job job=new Job(
                jsonJobObject.getString("_class"),
                jsonJobObject.getString("name"),
                jsonJobObject.getString("url"),
                jsonJobObject.getString("color")
            );

            // add description and build info to the job object
            fillJobBuildInfo(job);
            jobs.add(job);
        }
        return jobs;
    }

    /**
     * Takes job object and fill description and last build info into it
     *
     * @param job Job object that will be filled
     * @throws IOException If connection to jenkins fail
     */
    private void fillJobBuildInfo(Job job) throws IOException
    {
        JsonObject jobInfo = getJsonApiPage(job.getUrl());
        job.setDescription(readStringOrNull(jobInfo,"description"));

        JsonValue lastBuild = jobInfo.get("lastBuild");

        // if none build has been made, enter unknown status
        if (lastBuild.equals(JsonValue.NULL)){
            job.setLastBuildResult(new BuildResult(BuildStatus.UNKNOWN,null,null,null));
        }
        else {
            // if any build has been made, enter it's status
            int lastBuildNumber = jobInfo.getJsonObject("lastBuild").getInt("number");
            JsonObject lastBuildPage = getJsonApiPage(job.getUrl() + lastBuildNumber + "/");

            BuildResult lastBuildResult = new BuildResult(
                    BuildStatus.fromString(readStringOrNull(lastBuildPage, "result")),
                    lastBuildPage.getString("fullDisplayName"),
                    lastBuildPage.getString("url"),

                    // parse the milisecond timestamp from json page into LocalDateTime
                    LocalDateTime.ofInstant(Instant.ofEpochMilli(Integer.toUnsignedLong((lastBuildPage.getInt("timestamp")))),
                            TimeZone.getDefault().toZoneId())
            );
            job.setLastBuildResult(lastBuildResult);
        }
    }

    /**
     * Read Json from Jenkins and store it to object
     * @param url URL of the page, that will be read
     *      This method adds the suffix "/api"json" to read json content of the page
     * @return Json representation of the data on page
     * @throws IOException Throws if reading of page fails
     */
    private JsonObject getJsonApiPage(String url) throws IOException
    {
        String json = getStringApiPage(url + "/api/json");
        return Json.createReader(new StringReader(json)).readObject();
    }

    private String getStringApiPage(String url) throws IOException
    {
        return executor.execute(Request.Get(url)).returnContent().asString();
    }

    /**
     * Read json String object, which can possibly be NULL
     * @param object Json object to find data in
     * @param attribute Name of attribute that will be looked for
     * @return Empty string if json object is null, string content otherwise
     */
    private String readStringOrNull(JsonObject object, String attribute)
    {
        JsonValue jsonValue=object.get(attribute);
        if(jsonValue.getValueType().equals(JsonValue.ValueType.NULL)){
            return "";
        } else {
            return object.getString(attribute);
        }
    }

    /**
     * Get content of the output console for one specific build
     * @param buildName Name of the build
     * @return Plain text content of the output console
     * @throws IOException if connection to jenkins fails
     */
    public String readConsoleOutput(String buildName) throws IOException
    {
        return getStringApiPage(buildName + "consoleText");
    }
}
