package com.github.ladicek.rourka.jenkins;

import com.github.ladicek.rourka.ci.*;

import javax.json.*;
import javax.ws.rs.core.StreamingOutput;
import java.io.IOException;
import java.io.StringReader;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

public class JenkinsDataProvider {
    private JenkinsRequestHandler jenkinsRequestHandler;

    public JenkinsDataProvider (JenkinsRequestHandler jenkinsRequestHandler){
        this.jenkinsRequestHandler= jenkinsRequestHandler;
    }

    /**
     * List all jobs (builds) in jenkins and their last build results
     * @return List of all jobs
     * @throws IOException If connection to jenkins fails
     */
    public List<Job> getJobs() throws IOException {
        // get jobs from jenkins
        JsonObject page = jenkinsRequestHandler.getJsonApiPage("");
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
        JsonObject jobInfo = jenkinsRequestHandler.getFullUrlJsonApiPage(job.getUrl());

        // parse JSON present in description
        parseJobDescrption(job,jobInfo);

        JsonValue lastBuild = jobInfo.get("lastBuild");

        // if none build has been made, enter unknown status
        if (lastBuild.equals(JsonValue.NULL)){
            job.setLastBuildResult(new BuildResult(BuildStatus.UNKNOWN,0,null,null,null,null));
        }
        else {
            // if any build has been made, enter it's status
            int lastBuildNumber = jobInfo.getJsonObject("lastBuild").getInt("number");
            JsonObject lastBuildPage = jenkinsRequestHandler.getFullUrlJsonApiPage(job.getUrl() + lastBuildNumber + "/");

            BuildResult lastBuildResult = new BuildResult(
                    BuildStatus.fromString(readStringOrNull(lastBuildPage, "result")),
                    lastBuildNumber,
                    buildConsoleOutputUrl(job,lastBuildNumber),
                    buildBuildUrl(job),
                    readBooleanOrNull(lastBuildPage, "building"),

                    // parse the milisecond timestamp from json page into LocalDateTime
                    LocalDateTime.ofInstant(
                            Instant.ofEpochMilli(
                                new Long(lastBuildPage.get("timestamp").toString())
                            ),
                            TimeZone.getDefault().toZoneId())
            );
            job.setLastBuildResult(lastBuildResult);
        }
    }

    private void parseJobDescrption(Job job, JsonObject jobInfo)
    {
        try {
            String descriptionString = readStringOrNull(jobInfo, "description");
            JsonObject descriptionJson = Json.createReader(new StringReader(descriptionString)).readObject();

            if (descriptionJson != null) {
                job.setDescription(new PipelineDescription(
                        readStringOrNull(descriptionJson, "description")
                ));

                job.setType(new PipelineType(
                        readStringOrNull(descriptionJson, "type")
                ));

                job.setCluster(new Cluster(
                        readStringOrNull(descriptionJson, "cluster")
                ));
            } else {
                job.setDescription(new PipelineDescription(null));
                job.setType(new PipelineType(null));
                job.setCluster(new Cluster(null));
            }
        } catch (JsonException exception){
            job.setDescription(new PipelineDescription(null));
            job.setType(new PipelineType(null));
            job.setCluster(new Cluster(null));
        }
    }

    /**
     * Get content of the output console for one specific build
     * @param buildName Name of the build
     * @return Plain text content of the output console
     * @throws IOException if connection to jenkins fails
     */
    public StreamingOutput readConsoleOutput(String buildName, String buildNumber) throws IOException
    {
        return jenkinsRequestHandler.readConsoleOutput("/job/" + buildName + "/" + buildNumber + "/consoleText");
    }


    private String buildConsoleOutputUrl(Job job,int lastBuildNumber)
    {
        return "/console-text/" + job.getName() + "/" + lastBuildNumber;
    }

    private String buildBuildUrl(Job job)
    {
        return "/build/" + job.getName();
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

    private Boolean readBooleanOrNull(JsonObject object, String attribute)
    {
        JsonValue jsonValue=object.get(attribute);
        if(jsonValue.getValueType().equals(JsonValue.ValueType.NULL)){
            return null;
        } else {
            return object.getBoolean(attribute);
        }
    }
}
