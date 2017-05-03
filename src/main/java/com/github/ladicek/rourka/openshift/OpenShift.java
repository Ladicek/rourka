package com.github.ladicek.rourka.openshift;

import io.fabric8.kubernetes.client.Config;
import io.fabric8.kubernetes.client.ConfigBuilder;
import io.fabric8.openshift.client.DefaultOpenShiftClient;
import io.fabric8.openshift.client.OpenShiftClient;

import javax.enterprise.context.ApplicationScoped;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

@ApplicationScoped
public class OpenShift {
    private final Config openshiftConfig;

    public OpenShift() throws IOException {
        String master = "https://" + System.getenv("KUBERNETES_SERVICE_HOST") + ":" + System.getenv("KUBERNETES_SERVICE_PORT");
        String token = new String(Files.readAllBytes(Paths.get("/var/run/secrets/kubernetes.io/serviceaccount/token")), StandardCharsets.UTF_8);

        this.openshiftConfig = new ConfigBuilder()
                .withMasterUrl(master)
                .withOauthToken(token)
                .withTrustCerts(true)
                .build();
    }

    public OpenShiftClient createClient() {
        return new DefaultOpenShiftClient(openshiftConfig);
    }
}
