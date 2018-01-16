package com.github.ladicek.rourka;

import com.github.ladicek.rourka.jenkins.JenkinsClient;
import org.apache.http.HttpResponse;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

@Path("/start-build/{name}")
public class StartBuildResource {
    @Inject
    private JenkinsClient jenkins;

    @GET // TODO must be POST
    @Produces("text/plain;charset=utf-8")
    public String get(@PathParam("name") String jobName) throws Exception {
        HttpResponse response = jenkins.startBuild(jobName);
        if (response.getStatusLine().getStatusCode() == 201) {
            return "Build started";
        } else {
            return "Failed to start build, response: " + response.toString();
        }
    }
}
