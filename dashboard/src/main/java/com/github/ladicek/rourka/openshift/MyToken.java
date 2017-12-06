package com.github.ladicek.rourka.openshift;

import javax.enterprise.context.ApplicationScoped;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

@ApplicationScoped
public class MyToken {
    private final String value;

    public MyToken() throws IOException {
        this.value = new String(Files.readAllBytes(Paths.get("/var/run/secrets/kubernetes.io/serviceaccount/token")), StandardCharsets.UTF_8);
    }

    public String get() {
        return value;
    }
}
