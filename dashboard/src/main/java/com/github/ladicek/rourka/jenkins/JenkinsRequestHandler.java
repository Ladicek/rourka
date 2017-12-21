package com.github.ladicek.rourka.jenkins;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.fluent.Executor;
import org.apache.http.client.fluent.Request;

import javax.json.Json;
import javax.json.JsonObject;
import javax.ws.rs.core.StreamingOutput;
import java.io.IOException;
import java.io.StringReader;

/**
 * Handles communication with Jenkins
 */
public class JenkinsRequestHandler {
    private Executor executor;

    public JenkinsRequestHandler(HttpClient httpClient) throws Exception{
        executor = Executor.newInstance(httpClient);
        this.jenkinsUrl = JenkinsProperties.get("jenkins.url");
    }

    private final String jenkinsUrl;

    /**
     * Read Json from Jenkins and store it to object
     * @param url URL of the page, that will be read
     *      This method adds the prefix for jenkins URL
     *      also adds the suffix "/api"json" to read json content of the page
     * @return Json representation of the data on page
     * @throws IOException Throws if reading of page fails
     */
    public JsonObject getJsonApiPage(String url) throws IOException {
        String json = getStringApiPage(jenkinsUrl + url + "/api/json");
        return Json.createReader(new StringReader(json)).readObject();
    }

    /**
     * Read Json from Jenkins ans store it to object
     * Allow to enter full url
     *
     * @param url URL to the requested page
     *      This method adds the suffix /api/json to the url
     * @return Json reprezentation of the data on page
     * @throws IOException Throws if reading of page fails
     */
    public JsonObject getFullUrlJsonApiPage(String url) throws IOException {
        String json = getStringApiPage(url + "/api/json");
        return Json.createReader(new StringReader(json)).readObject();
    }

    private String getStringApiPage(String url) throws IOException {
        return executor.execute(Request.Get(url)).returnContent().asString();
    }

    /**
     * Get content of the output console for one specific build
     * @return Plain text content of the output console
     * @throws IOException if connection to jenkins fails
     */
    public StreamingOutput readConsoleOutput(String url) throws IOException {
        return output -> executor.execute(Request.Get(jenkinsUrl + url)).returnResponse().getEntity().writeTo(output);
    }

    /**
     * Send empty HTTP POST request to the specified page
     * @param url URL of the requested page
     *      This method adds the prefix of jenkinsUrl
     * @return Response to the request
     * @throws IOException If request handling fails
     */
    public HttpResponse sendPostRequest(String url) throws IOException {
        Request post= Request.Post(jenkinsUrl + url);
        return executor.execute(post).returnResponse();
    }
}
