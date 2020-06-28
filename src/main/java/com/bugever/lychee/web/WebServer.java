package com.bugever.lychee.web;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.util.ConfigUtil;
import org.eclipse.jetty.annotations.AnnotationConfiguration;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.webapp.Configuration;
import org.eclipse.jetty.webapp.WebAppContext;
import org.eclipse.jetty.webapp.WebInfConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.sql.SQLException;

public class WebServer {

    private static final Logger log = LoggerFactory.getLogger(WebServer.class);

    public static void main(String[] args) {
        try {
            Database.init(ConfigUtil.get("database.url"),
                    ConfigUtil.get("database.user"),
                    ConfigUtil.get("database.password"));
        } catch (SQLException | IOException e) {
            log.error("Database init failed.", e);
            return;
        }

        Server server = new Server(ConfigUtil.getInt("web.port"));
        WebAppContext webapp = new WebAppContext();
        webapp.setResourceBase("webapp");
        webapp.setConfigurations(new Configuration[] {
                new AnnotationConfiguration(),
                new WebInfConfiguration()
        });
        server.setHandler(webapp);
        try {
            server.start();
            server.join();
        } catch (Exception e) {
            log.error("Web server starting failed.", e);
        }
    }
}
