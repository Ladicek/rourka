package com.github.ladicek.rourka.openshift;

import io.fabric8.kubernetes.client.Config;
import io.fabric8.kubernetes.client.ConfigBuilder;
import io.fabric8.openshift.client.DefaultOpenShiftClient;
import io.fabric8.openshift.client.OpenShiftClient;
import org.wildfly.swarm.spi.runtime.annotations.ConfigurationValue;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.Disposes;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;

@ApplicationScoped
public class OpenShiftClientProducer {
    @Inject
    private MyToken myToken;

    @Inject
    @ConfigurationValue("rourka.openshift.url")
    private String openshiftUrl;

    @PostConstruct
    public void init() {
        if (openshiftUrl == null) {
            // default inside OpenShift
            openshiftUrl = "https://" + System.getenv("KUBERNETES_SERVICE_HOST") + ":" + System.getenv("KUBERNETES_SERVICE_PORT");
        }
    }

    @Produces
    @RequestScoped
    public OpenShiftClient createOpenShiftClient() {
        Config config = new ConfigBuilder()
                .withMasterUrl(openshiftUrl)
                .withOauthToken(myToken.get())
                .withTrustCerts(true)
                .build();
        return new DefaultOpenShiftClient(config);
    }

    public void closeHttpClient(@Disposes OpenShiftClient openShiftClient) {
        openShiftClient.close();
    }
}
