package com.github.ladicek.rourka.jenkins;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class JenkinsProperties {

	private static Properties properties;

	/*
	 Open and load a properties file
	 */
	static {
		try {
			ClassLoader loader = JenkinsProperties.class.getClassLoader();
			InputStream in = loader.getResourceAsStream("jenkins.properties");
			properties = new Properties();
			properties.load(in);
		} catch (IOException ex){
			System.err.println("Unable to open jenkins properties file");
			ex.printStackTrace();
		}
	}

	public static String get(String key){
		return properties.getProperty(key);
	}
}
