package com.github.ladicek.rourka.openshift;

import io.fabric8.kubernetes.client.Config;
import io.fabric8.kubernetes.client.ConfigBuilder;
import io.fabric8.openshift.client.DefaultOpenShiftClient;
import io.fabric8.openshift.client.OpenShiftClient;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.Disposes;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import java.io.IOException;
import java.security.GeneralSecurityException;

@ApplicationScoped
public class OpenShiftClientProducer {
    @Inject
    private MyToken myToken;

    @Produces
    @RequestScoped
    public OpenShiftClient createOpenShiftClient() throws IOException, GeneralSecurityException {
        String master = "https://" + System.getenv("KUBERNETES_SERVICE_HOST") + ":" + System.getenv("KUBERNETES_SERVICE_PORT");

        Config config = new ConfigBuilder()
                .withMasterUrl(master)
                .withOauthToken(myToken.get())
                .withTrustCerts(true)
                .build();
        return new DefaultOpenShiftClient(config);
    }

    public void closeHttpClient(@Disposes OpenShiftClient openShiftClient) throws IOException {
        openShiftClient.close();
    }
}
