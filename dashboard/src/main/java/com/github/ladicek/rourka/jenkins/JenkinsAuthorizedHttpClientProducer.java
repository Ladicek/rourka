package com.github.ladicek.rourka.jenkins;

import org.apache.http.HttpHeaders;
import org.apache.http.HttpRequestInterceptor;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.Disposes;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.net.ssl.SSLContext;
import javax.xml.bind.DatatypeConverter;
import java.io.IOException;
import java.security.GeneralSecurityException;

@ApplicationScoped
public class JenkinsAuthorizedHttpClientProducer {

    @Inject
    private JenkinsCredentials jenkinsCredentials;

    @Produces
    @RequestScoped
    @JenkinsAuthorizedHttpClient
    public CloseableHttpClient createHttpClient() throws IOException, GeneralSecurityException {
        SSLContext sslContext = SSLContexts.custom()
                .loadTrustMaterial((chain, authType) -> true)
                .build();

        CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
        credentialsProvider.setCredentials(
                new AuthScope(AuthScope.ANY_REALM, AuthScope.ANY_PORT),
                new UsernamePasswordCredentials(jenkinsCredentials.getLogin(), jenkinsCredentials.getApiToken()));


        String authStr = jenkinsCredentials.getLogin() +":"+  jenkinsCredentials.getApiToken();
        String encodedCredentials = DatatypeConverter.printBase64Binary(authStr.getBytes("utf-8"));

        return HttpClients.custom()
                .setSSLContext(sslContext)
                .setSSLHostnameVerifier(NoopHostnameVerifier.INSTANCE)
                .setDefaultCredentialsProvider(credentialsProvider)
                .addInterceptorLast((HttpRequestInterceptor) (req, ctx) -> {
                    req.addHeader(HttpHeaders.AUTHORIZATION, "Basic " + encodedCredentials);
                })
                .build();
    }

    public void closeHttpClient(@Disposes @JenkinsAuthorizedHttpClient CloseableHttpClient httpClient) throws IOException {
        httpClient.close();
    }
}
