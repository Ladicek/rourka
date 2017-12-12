package com.github.ladicek.rourka;

import com.github.ladicek.rourka.ci.BuildResult;
import com.github.ladicek.rourka.ci.Cluster;
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
        List<PipelineType> header = new ArrayList<>();

        Map<Cluster, Map<PipelineDescription, Map<PipelineType, BuildResult>>> tables = new LinkedHashMap<>();

        for (Job job : jobs){
            Map<PipelineDescription, Map<PipelineType, BuildResult>> table =
                    tables.computeIfAbsent(job.getCluster(), k -> new LinkedHashMap<>());

            if (!header.contains(job.getType())){
                header.add(job.getType());
            }

            table.computeIfAbsent(job.getDescription(), ignored -> new LinkedHashMap<>()).put(job.getType(), job.getLastBuildResult());
        }

        System.out.println("Table data: " + tables);
        return new View("index.html",
                "tables", tables,
                "header", header,
                "now", LocalDateTime.now()
        );
    }
}
