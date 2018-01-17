package com.github.ladicek.rourka;

import com.github.ladicek.rourka.ci.TestCluster;
import com.github.ladicek.rourka.ci.TestDescription;
import com.github.ladicek.rourka.ci.TestResult;
import com.github.ladicek.rourka.ci.TestType;
import com.github.ladicek.rourka.jenkins.JenkinsClient;
import com.github.ladicek.rourka.jenkins.Job;
import com.github.ladicek.rourka.thymeleaf.View;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.function.Function;

@Path("/")
public class IndexResource {
    @Inject
    private JenkinsClient jenkins;

    @GET
    @Produces(MediaType.TEXT_HTML)
    public View get(@QueryParam("flash") String flash) throws Exception {
        List<Job> jobs = jenkins.getRelevantJobs();

        SortedSet<TestType> header = newSortedSet(TestType::toString);
        Map<TestCluster, Map<TestDescription, Map<TestType, TestResult>>> tables = newSortedMap(TestCluster::toString);

        for (Job job : jobs) {
            header.add(job.getType());

            Map<TestDescription, Map<TestType, TestResult>> table =
                    tables.computeIfAbsent(job.getCluster(), ignored -> newSortedMap(TestDescription::toString));

            table.computeIfAbsent(job.getDescription(), ignored -> newSortedMap(TestType::toString))
                    .put(job.getType(), job.getLastResult());
        }

        return new View("index.html",
                "tables", tables,
                "header", header,
                "now", LocalDateTime.now(),
                "flash", flash
        );
    }

    private static <E, C extends Comparable<C>> SortedSet<E> newSortedSet(Function<E, C> compareBy) {
        return new TreeSet<>(Comparator.comparing(compareBy));
    }

    private static <K, V, C extends Comparable<C>> SortedMap<K, V> newSortedMap(Function<K, C> compareBy) {
        return new TreeMap<>(Comparator.comparing(compareBy));
    }
}
