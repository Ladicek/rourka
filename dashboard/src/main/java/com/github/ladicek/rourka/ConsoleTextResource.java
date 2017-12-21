package com.github.ladicek.rourka;

import com.github.ladicek.rourka.jenkins.JenkinsDataProvider;
import com.github.ladicek.rourka.jenkins.JenkinsRequestHandler;
import com.github.ladicek.rourka.openshift.TokenAuthorizingHttpClient;
import org.apache.http.impl.client.CloseableHttpClient;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.StreamingOutput;

@Path("/console-text/{build}/{number}")
public class ConsoleTextResource
{
	@Inject
	@TokenAuthorizingHttpClient
	private CloseableHttpClient httpClient;

	/**
	 * Print console output of the build to the http response
	 * @param buildName Name of the build
	 * @param buildNumber Number of the build
	 */
	@GET
	@Produces("text/plain;charset=utf-8") // as Jenkins responses in utf-8 too
	public StreamingOutput get(@PathParam("build") String buildName, @PathParam("number") String buildNumber) throws Exception {
		JenkinsDataProvider jenkinsDataProvider=new JenkinsDataProvider(new JenkinsRequestHandler(httpClient));
		return jenkinsDataProvider.readConsoleOutput(buildName,buildNumber);
	}
}