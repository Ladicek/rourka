package com.github.ladicek.rourka;

import com.github.ladicek.rourka.jenkins.JenkinsClient;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.StreamingOutput;

@Path("/console-text/{buildName}/{buildNumber}")
public class ConsoleTextResource {
    public static String link(String buildName, int buildNumber) {
        return "/console-text/" + buildName + "/" + buildNumber;
    }

    @Inject
    private JenkinsClient jenkins;

    @GET
    @Produces("text/plain;charset=utf-8") // as Jenkins responds in utf-8 too
    public StreamingOutput get(@PathParam("buildName") String buildName, @PathParam("buildNumber") String buildNumber) {
        return out -> jenkins.streamConsoleText(buildName, buildNumber).writeTo(out);
    }
}
