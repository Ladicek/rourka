package com.github.ladicek.rourka;

import com.github.ladicek.rourka.ci.BuildResult;
import com.github.ladicek.rourka.ci.PipelineDescription;
import com.github.ladicek.rourka.ci.PipelineType;
import com.github.ladicek.rourka.jenkins.JenkinsDataProvider;
import com.github.ladicek.rourka.jenkins.Job;
import com.github.ladicek.rourka.openshift.TokenAuthorizingHttpClient;
import com.github.ladicek.rourka.thymeleaf.View;
import org.apache.http.impl.client.CloseableHttpClient;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Path("/")
public class IndexResource {
    @Inject
    @TokenAuthorizingHttpClient
    private CloseableHttpClient httpClient;

    @GET
    @Produces(MediaType.TEXT_HTML)
    public View get() throws Exception {
        JenkinsDataProvider jenkinsDataProvider=new JenkinsDataProvider(httpClient);
        List<Job> jobs=jenkinsDataProvider.getJobs();

        Map<PipelineDescription, Map<PipelineType, BuildResult>> table = new LinkedHashMap<>();

        // TODO: figure out how to do a description and type passing
        for (Job job : jobs){
            PipelineDescription desc = new PipelineDescription(job.getDescription());
            PipelineType type = new PipelineType("type placeholder");
            table.computeIfAbsent(desc, ignored -> new LinkedHashMap<>()).put(type, job.getLastBuildResult());
        }

        List<PipelineType> header = new ArrayList<>();
        header.add(new PipelineType("type placeholder"));


        return new View("index.html",
                "table", table,
                "header", header,
                "now", LocalDateTime.now()
        );
    }
}
