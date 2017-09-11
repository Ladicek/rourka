package com.github.ladicek.rourka;

import io.fabric8.openshift.client.OpenShiftClient;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

@Path("/ready")
public class ReadinessResource {
    @Inject
    private OpenShiftClient oc;

    @GET
    public Response get() {
        oc.currentUser();
        return Response.ok().build();
    }
}
