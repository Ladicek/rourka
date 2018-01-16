package com.github.ladicek.rourka;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

@Path("/junit") // TODO need to rewrite on top of Jenkins instead of OpenShift
public class JUnitResource {
    @GET
    public Response get() {
        return Response.serverError().build();
    }

/*
    @Inject
    private OpenShiftClient oc;

    @Inject
    @TokenAuthorizingHttpClient
    private CloseableHttpClient httpClient;

    @GET
    @Produces(MediaType.APPLICATION_OCTET_STREAM)
    public Response get() {
        List<BuildConfig> buildConfigs = oc.buildConfigs()
                .list()
                .getItems()
                .stream()
                .filter(bc -> bc.getMetadata().getAnnotations() != null
                        && bc.getMetadata().getAnnotations().containsKey("ci/type")
                        && bc.getMetadata().getAnnotations().containsKey("ci/description"))
                .sorted(Comparator.comparing(bc -> bc.getMetadata().getAnnotations().get("ci/description")))
                .collect(Collectors.toList());

        List<Build> builds = oc.builds()
                .withLabelIn("openshift.io/build-config.name", buildConfigs.stream()
                        .map(bc -> bc.getMetadata().getName())
                        .toArray(String[]::new))
                .list()
                .getItems();

        StreamingOutput result = output -> {
            try (ZipOutputStream zip = new ZipOutputStream(output)) {
                for (BuildConfig buildConfig : buildConfigs) {
                    String name = buildConfig.getMetadata().getName();

                    builds.stream()
                            .filter(b -> name.equals(b.getMetadata().getLabels().get("openshift.io/build-config.name")))
                            .filter(b -> b.getStatus().getCompletionTimestamp() != null)
                            .max(Comparator.comparingInt(b -> Integer.parseInt(b.getMetadata().getAnnotations().get("openshift.io/build.number"))))
                            .map(this::createJunitXmls)
                            .orElseGet(() -> fallbackJUnitXml(name))
                            .forEach(junitXml -> junitXml.writeToZip(zip));
                }
            }
        };

        return Response.ok(result)
                .header("Content-Disposition", "attachment; filename=\"junit-results.zip\"")
                .build();
    }

    private static class JUnitXml {
        private final String name;
        private final String content;

        JUnitXml(String name, String content) {
            this.name = name;
            this.content = content;
        }

        void writeToZip(ZipOutputStream zip) {
            try {
                PrintStream writer = new PrintStream(new BufferedOutputStream(zip));
                zip.putNextEntry(new ZipEntry(name));
                writer.print(content);
                writer.flush();
                zip.closeEntry();
            } catch (IOException e) {
                throw new UncheckedIOException(e);
            }
        }
    }

    private List<JUnitXml> createJunitXmls(Build build) {
        try {
            return doCreateJunitXmls(build);
        } catch (SAXException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    private List<JUnitXml> doCreateJunitXmls(Build build) throws IOException, SAXException {
        String buildConfigName = build.getMetadata().getLabels().get("openshift.io/build-config.name");
        String url = build.getMetadata().getAnnotations().get("openshift.io/jenkins-build-uri");

        Executor executor = Executor.newInstance(httpClient);
        String json = executor.execute(Request.Get(url + "/wfapi/artifacts")).returnContent().asString();
        List<JsonObject> testArtifacts = Json.createReader(new StringReader(json))
                .readArray()
                .stream()
                .map(JsonObject.class::cast)
                .filter(o -> o.getString("name").startsWith("TEST-") && o.getString("name").endsWith(".xml"))
                .collect(Collectors.toList());

        if (testArtifacts.isEmpty()) {
            return fallbackJUnitXml(buildConfigName);
        }

        List<JUnitXml> result = new ArrayList<>();
        for (JsonObject testArtifact : testArtifacts) {
            String junitXmlName = testArtifact.getString("name");
            String junitXmlUrl = testArtifact.getString("url");
            String junitXml = executor.execute(Request.Get("http://jenkins/" + junitXmlUrl)).returnContent().asString();
            Match doc = null;
            doc = $(new StringReader(junitXml));
            $(doc).each(el -> {
                String name = $(el).attr("name");
                $(el).attr("name", buildConfigName + "." + name);
            });
            $(doc).find("testcase").each(el -> {
                String name = $(el).attr("classname");
                $(el).attr("classname", buildConfigName + "." + name);
            });
            StringWriter out = new StringWriter();
            doc.write(out);
            String finalJunitXmlName = junitXmlName.replace("TEST-", "TEST-" + buildConfigName + ".");
            result.add(new JUnitXml(finalJunitXmlName, out.toString()));
        }

        return result;
    }

    private List<JUnitXml> fallbackJUnitXml(String buildConfigName) {
        JUnitXml result = new JUnitXml("TEST-" + buildConfigName + ".Test.xml",
                "<testsuite tests=\"1\" errors=\"1\" name=\"" + buildConfigName + ".Test\">\n" +
                        "    <testcase classname=\"" + buildConfigName + ".Test\" name=\"test\">\n" +
                        "        <error type=\"TestFailed\">Too bad, no more info! Maybe the build failed entirely?</error>\n" +
                        "    </testcase>\n" +
                        "</testsuite>");
        return Collections.singletonList(result);
    }
*/
}
