package com.bugever.visa;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class CurrentUser {

    public final Map<String, String> attributes = new HashMap<>();

    public static CurrentUser init(HttpServletRequest request) {
        CurrentUser currentUser = new CurrentUser();
        currentUser.attributes.put("seller", "1003");
        return currentUser;
    }
}
