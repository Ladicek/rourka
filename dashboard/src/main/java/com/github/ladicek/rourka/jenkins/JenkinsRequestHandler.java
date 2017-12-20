package com.github.ladicek.rourka.jenkins;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.fluent.Executor;
import org.apache.http.client.fluent.Request;
import org.apache.http.impl.client.CloseableHttpClient;

import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonObject;
import javax.ws.rs.core.StreamingOutput;
import java.io.IOException;
import java.io.StringReader;

public class JenkinsRequestHandler {
    private Executor executor;

    @Inject
    @JenkinsAuthorizedHttpClient
    private CloseableHttpClient httpClient;

    public JenkinsRequestHandler(HttpClient httpClient) throws Exception{
        executor = Executor.newInstance(httpClient);
        this.jenkinsUrl = JenkinsProperties.get("jenkins.url");
    }

    private final String jenkinsUrl;

    /**
     * Read Json from Jenkins and store it to object
     * @param url URL of the page, that will be read
     *      This method adds the suffix "/api"json" to read json content of the page
     * @return Json representation of the data on page
     * @throws IOException Throws if reading of page fails
     */
    public JsonObject getJsonApiPage(String url) throws IOException
    {
        String json = getStringApiPage(jenkinsUrl + url + "/api/json");
        return Json.createReader(new StringReader(json)).readObject();
    }

    public JsonObject getFullUrlJsonApiPage(String url) throws IOException
    {
        String json = getStringApiPage(url + "/api/json");
        return Json.createReader(new StringReader(json)).readObject();
    }

    private String getStringApiPage(String url) throws IOException
    {
//        System.out.println("requesting url: "+ url);
        return executor.execute(Request.Get(url)).returnContent().asString();
    }

    /**
     * Get content of the output console for one specific build
     * @return Plain text content of the output console
     * @throws IOException if connection to jenkins fails
     */
    public StreamingOutput readConsoleOutput(String url) throws IOException
    {
        return output -> executor.execute(Request.Get(jenkinsUrl + url)).returnResponse().getEntity().writeTo(output);
    }

    public HttpResponse sendPostRequest(String url) throws IOException
    {
        Request post= Request.Post(jenkinsUrl + url);
        return executor.execute(post).returnResponse();
    }
}
