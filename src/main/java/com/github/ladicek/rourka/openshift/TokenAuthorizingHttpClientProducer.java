package com.github.ladicek.rourka.openshift;

import org.apache.http.HttpHeaders;
import org.apache.http.HttpRequestInterceptor;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.Disposes;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.net.ssl.SSLContext;
import java.io.IOException;
import java.security.GeneralSecurityException;

@ApplicationScoped
public class TokenAuthorizingHttpClientProducer {
    @Inject
    private MyToken myToken;

    @Produces
    @RequestScoped
    @TokenAuthorizingHttpClient
    public CloseableHttpClient createHttpClient() throws IOException, GeneralSecurityException {
        SSLContext sslContext = SSLContexts.custom()
                .loadTrustMaterial((chain, authType) -> true)
                .build();

        return HttpClients.custom()
                .setSSLContext(sslContext)
                .setSSLHostnameVerifier(NoopHostnameVerifier.INSTANCE)
                .addInterceptorLast((HttpRequestInterceptor) (req, ctx) -> {
                    req.addHeader(HttpHeaders.AUTHORIZATION, "Bearer " + myToken.get());
                })
                .build();
    }

    public void closeHttpClient(@Disposes @TokenAuthorizingHttpClient CloseableHttpClient httpClient) throws IOException {
        httpClient.close();
    }
}
