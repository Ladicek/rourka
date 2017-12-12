package com.github.ladicek.rourka.ci;

public enum BuildStatus {
    PASS,
    FAIL,
    UNKNOWN;

    public static BuildStatus fromString(String statusString)
    {
        switch (statusString) {
            case "SUCCESS":
                return BuildStatus.PASS;
            case "FAILED":
                return BuildStatus.FAIL;
            default:
                return BuildStatus.UNKNOWN;
        }
    }
}
