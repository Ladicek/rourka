package com.github.ladicek.rourka;

import com.github.ladicek.rourka.jenkins.JenkinsClient;
import com.github.ladicek.rourka.jenkins.StartedBuild;

import javax.inject.Inject;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.net.URI;

@Path("/start-build/{buildName}")
public class StartBuildResource {
    public static String link(String buildName) {
        return "/start-build/" + buildName;
    }

    @Inject
    private JenkinsClient jenkins;

    @POST
    public Response post(@PathParam("buildName") String buildName, @Context UriInfo uri) throws Exception {
        StartedBuild startedBuild = jenkins.startBuild(buildName);

        URI redirect;
        if (startedBuild.success) {
            redirect = uri.getBaseUriBuilder()
                    .queryParam("flash", "Build {buildName} started successfully")
                    .build(buildName);
        } else {
            redirect = uri.getBaseUriBuilder()
                    .queryParam("flash", "Failed to start build {buildName}: {errorMessage}")
                    .build(buildName, startedBuild.errorMessage);
        }

        return Response.seeOther(redirect).build();
    }
}
