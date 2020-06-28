package com.bugever.lychee.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

public class ConfigUtil {

    private static final Logger log = LoggerFactory.getLogger(ConfigUtil.class);

    private static Properties props = new Properties();

    static {
        try {
            props.load(new InputStreamReader(ConfigUtil.class.getResourceAsStream("/conf.default.properties"), "UTF-8"));
            try {
                props.load(new InputStreamReader(ConfigUtil.class.getResourceAsStream("/conf.properties"), "UTF-8"));
            } catch (FileNotFoundException e) {
                log.info("conf.properties not found. Using conf.default.properties instead.");
            } catch (IOException e) {
                log.info("conf.properties reading failed. Using conf.default.properties instead.", e);
            }
        } catch (IOException e) {
            log.error("conf.default.properties reading failed. Application exits.", e);
            System.exit(1);
        }
    }

    public static String get(String key) {
        return (String) props.get(key);
    }

    public static int getInt(String key) {
        return Integer.parseInt(get(key));
    }
}
