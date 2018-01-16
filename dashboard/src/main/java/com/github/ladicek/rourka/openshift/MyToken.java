package com.github.ladicek.rourka.openshift;

import org.wildfly.swarm.spi.runtime.annotations.ConfigurationValue;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

@ApplicationScoped
public class MyToken {
    @Inject
    @ConfigurationValue("rourka.openshift.token")
    private String value;

    @PostConstruct
    public void init() {
        if (value == null) {
            try {
                // default inside OpenShift
                value = new String(Files.readAllBytes(Paths.get("/var/run/secrets/kubernetes.io/serviceaccount/token")), StandardCharsets.UTF_8);
            } catch (IOException e) {
                throw new UncheckedIOException(e);
            }
        }
    }

    public String get() {
        return value;
    }
}
