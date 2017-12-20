package com.github.ladicek.rourka;

import com.github.ladicek.rourka.jenkins.JenkinsAuthorizedHttpClient;
import com.github.ladicek.rourka.jenkins.JenkinsBuildRunner;
import com.github.ladicek.rourka.jenkins.JenkinsRequestHandler;
import org.apache.http.HttpResponse;
import org.apache.http.impl.client.CloseableHttpClient;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

@Path("/build/{name}")
public class BuildResource {
    private JenkinsBuildRunner jenkinsBuildRunner;

    @Inject
    @JenkinsAuthorizedHttpClient
    private CloseableHttpClient httpClient;

    @GET
    @Produces("text/plain;charset=utf-8")
    public String get(@PathParam("name") String buildName) throws Exception {
        jenkinsBuildRunner = new JenkinsBuildRunner(new JenkinsRequestHandler(httpClient));

        HttpResponse response=jenkinsBuildRunner.startBuild(buildName);
        if (response.getStatusLine().getStatusCode() == 302)
        {
            return "Build started";
        } else {
            return "Failed to start build, response: " + response.toString();
        }
    }
}