package com.bugever.lychee.web.servlet;

import com.bugever.lychee.web.WebServer;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.Callable;

public class ServletHandler {

    private static final Logger log = LoggerFactory.getLogger(ServletHandler.class);

    public static void handle(HttpServletRequest request, HttpServletResponse response,
                              Callable<?> bodyCallable) {
        response.setContentType("application/json; charset=utf8");
        try {
            Object body = bodyCallable.call();
            String json = "{ \"code\": 0, \"body\": " + new ObjectMapper().writeValueAsString(body) + " }";
            response.getOutputStream().write(json.getBytes());
        } catch (Exception e) {
            log.warn("Servlet handling failed", e);
            try {
                String json = "{ \"code\": 1, \"message\": \"Internal Errors\" }";
                response.getOutputStream().write(json.getBytes());
            } catch (IOException e1) {
                log.warn("Error output failed", e1);
            }
        }
    }
}
