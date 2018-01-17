package com.github.ladicek.rourka.thymeleaf;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class View {
    final String templatePath;
    final Map<String, Object> variables;

    public View(String templatePath) {
        this(templatePath, null);
    }

    public View(String templatePath,
                String key1, Object value1) {
        this(templatePath, createMap(key1, value1));
    }

    public View(String templatePath,
                String key1, Object value1,
                String key2, Object value2) {
        this(templatePath, createMap(key1, value1, key2, value2));
    }

    public View(String templatePath,
                String key1, Object value1,
                String key2, Object value2,
                String key3, Object value3) {
        this(templatePath, createMap(key1, value1, key2, value2, key3, value3));
    }

    public View(String templatePath,
                String key1, Object value1,
                String key2, Object value2,
                String key3, Object value3,
                String key4, Object value4) {
        this(templatePath, createMap(key1, value1, key2, value2, key3, value3, key4, value4));
    }

    public View(String templatePath, Map<String, Object> variables) {
        this.templatePath = templatePath;
        this.variables = variables != null ? variables : Collections.emptyMap();
    }

    private static Map<String, Object> createMap(String key1, Object value1) {
        Map<String, Object> result = new HashMap<>();
        result.put(key1, value1);
        return result;
    }

    private static Map<String, Object> createMap(String key1, Object value1,
                                                 String key2, Object value2) {
        Map<String, Object> result = new HashMap<>();
        result.put(key1, value1);
        result.put(key2, value2);
        return result;
    }

    private static Map<String, Object> createMap(String key1, Object value1,
                                                 String key2, Object value2,
                                                 String key3, Object value3) {
        Map<String, Object> result = new HashMap<>();
        result.put(key1, value1);
        result.put(key2, value2);
        result.put(key3, value3);
        return result;
    }

    private static Map<String, Object> createMap(String key1, Object value1,
                                                 String key2, Object value2,
                                                 String key3, Object value3,
                                                 String key4, Object value4) {
        Map<String, Object> result = new HashMap<>();
        result.put(key1, value1);
        result.put(key2, value2);
        result.put(key3, value3);
        result.put(key4, value4);
        return result;
    }
}
