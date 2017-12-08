package com.github.ladicek.rourka;

import com.github.ladicek.rourka.openshift.TokenAuthorizingHttpClient;
import io.fabric8.openshift.api.model.Build;
import io.fabric8.openshift.client.OpenShiftClient;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.StreamingOutput;

@Path("/console-text/{build}")
public class ConsoleTextResource {
    @Inject
    private OpenShiftClient oc;

    @Inject
    @TokenAuthorizingHttpClient
    private CloseableHttpClient httpClient;

    @GET
    @Produces("text/plain;charset=utf-8") // as Jenkins responses in utf-8 too
    public StreamingOutput get(@PathParam("build") String buildName) {
        Build build = oc.builds().withName(buildName).get();
        String consoleTextUrl = build.getMetadata().getAnnotations().get("openshift.io/jenkins-log-url");

        return output -> {
            HttpGet request = new HttpGet(consoleTextUrl);
            try (CloseableHttpResponse response = httpClient.execute(request)) {
                response.getEntity().writeTo(output);
            }
        };
    }
}
