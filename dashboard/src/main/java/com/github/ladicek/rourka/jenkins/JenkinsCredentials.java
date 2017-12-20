package com.github.ladicek.rourka.jenkins;


import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class JenkinsCredentials {
    private String login;
    private String apiToken;

    public JenkinsCredentials (){
        this.login = JenkinsProperties.get("jenkins.login");
        this.apiToken = JenkinsProperties.get("jenkins.apiToken");
    }

    public String getLogin() {
        return login;
    }

    public String getApiToken() {
        return apiToken;
    }
}
