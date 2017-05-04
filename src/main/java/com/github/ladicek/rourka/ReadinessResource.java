package com.github.ladicek.rourka;

import com.github.ladicek.rourka.openshift.OpenShift;
import io.fabric8.openshift.client.OpenShiftClient;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

@Path("/ready")
public class ReadinessResource {
    @Inject
    private OpenShift openshift;

    @GET
    public Response get() {
        try (OpenShiftClient oc = openshift.createClient()) {
            oc.currentUser();
            return Response.ok().build();
        }
    }
}
