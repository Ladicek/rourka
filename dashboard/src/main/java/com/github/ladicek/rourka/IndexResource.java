package com.github.ladicek.rourka;

import com.github.ladicek.rourka.ci.*;
import com.github.ladicek.rourka.jenkins.JenkinsDataProvider;
import com.github.ladicek.rourka.jenkins.JenkinsRequestHandler;
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
		JenkinsDataProvider jenkinsDataProvider=new JenkinsDataProvider(new JenkinsRequestHandler(httpClient));
		List<Job> jobs=jenkinsDataProvider.getJobs();

		// declare output variables
		List<PipelineType> header = new ArrayList<>();
		Map<Cluster, Map<PipelineDescription, Map<PipelineType, Job>>> tables = new LinkedHashMap<>();

		// fill output structure with jobs
		for (Job job : jobs){
			if (!job.getDescription().toString().equals(ValueWrapper.emptyValue)) {
				// create or select table (representing cluster)
				Map<PipelineDescription, Map<PipelineType, Job>> table =
						tables.computeIfAbsent(job.getCluster(), k -> new LinkedHashMap<>());

				// add job type to the header, if not already present
				if (!header.contains(job.getType())){
					header.add(job.getType());
				}

				// insert job into table
				// insert only if description is present => job is annotated as a build that should be displayed
				table.computeIfAbsent(job.getDescription(), ignored -> new LinkedHashMap<>()).put(job.getType(), job);
			}
		}

		return new View("index.html",
				"tables", tables,
				"header", header,
				"now", LocalDateTime.now()
		);
	}
}
