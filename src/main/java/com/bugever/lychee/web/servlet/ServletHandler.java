package com.bugever.lychee.web.servlet;

import com.bugever.visa.CurrentUser;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;

public class ServletHandler {

    private static final Logger log = LoggerFactory.getLogger(ServletHandler.class);

    public static void handle(HttpServletRequest request, HttpServletResponse response,
                              ApiCallableVoidInput<?> apiCallable) {
        handle(request, response, Void.class, apiCallable);
    }

    public static <IN> void handle(HttpServletRequest request, HttpServletResponse response,
                                   Class<IN> inputType, ApiCallable<IN, ?> apiCallable) {
        response.setContentType("application/json; charset=utf8");
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm"));

            CurrentUser currentUser = CurrentUser.init(request);

            String inputJson = IOUtils.toString(request.getInputStream());
            IN input = objectMapper.readValue(inputJson, inputType);

            Object body = apiCallable.call(currentUser, input);

            String json = "{ \"code\": 0, \"body\": " + (body == null ? "{}" : objectMapper.writeValueAsString(body)) + " }";
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

    public interface ApiCallableVoidInput<OUT> extends ApiCallable<Void, OUT> {

        OUT call(CurrentUser currentUser) throws Exception;

        @Override
        default OUT call(CurrentUser currentUser, Void input) throws Exception {
            return call(currentUser);
        }
    }

    public interface ApiCallable<IN, OUT> {
        OUT call(CurrentUser currentUser, IN input) throws Exception;
    }
}
