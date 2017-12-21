package com.github.ladicek.rourka.jenkins;

import org.apache.http.HttpResponse;

import java.io.IOException;

public class JenkinsBuildRunner {
	private JenkinsRequestHandler jenkinsRequestHandler;

	public JenkinsBuildRunner(JenkinsRequestHandler jenkinsRequestHandler) {
		this.jenkinsRequestHandler = jenkinsRequestHandler;
	}

	public HttpResponse startBuild(String jobName) throws IOException {
		return jenkinsRequestHandler.sendPostRequest("/job/" + jobName + "/build");
	}
}
