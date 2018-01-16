package com.github.ladicek.rourka.ci;

public enum BuildStatus {
    PASS,
    FAIL,
    UNKNOWN,
    ;

    public static BuildStatus from(String string) {
        switch (string) {
            case "SUCCESS":
                return BuildStatus.PASS;
            case "FAILED":
            case "FAILURE":
                return BuildStatus.FAIL;
            default:
                return BuildStatus.UNKNOWN;
        }
    }
}
