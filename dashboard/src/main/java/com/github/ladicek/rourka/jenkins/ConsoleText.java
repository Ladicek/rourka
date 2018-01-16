package com.github.ladicek.rourka.jenkins;

import org.apache.http.client.HttpClient;
import org.apache.http.client.fluent.Executor;
import org.apache.http.client.fluent.Request;

import java.io.IOException;
import java.io.OutputStream;

public final class ConsoleText {
    private final HttpClient httpClient;
    private final String url;

    ConsoleText(HttpClient httpClient, String url) {
        this.httpClient = httpClient;
        this.url = url;
    }

    public void writeTo(OutputStream out) throws IOException {
        Executor.newInstance(httpClient).execute(Request.Get(url)).returnResponse().getEntity().writeTo(out);
    }
}
