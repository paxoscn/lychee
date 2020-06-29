package com.bugever.visa;

import javax.servlet.http.HttpServletRequest;

public class CurrentUser {

    public static CurrentUser init(HttpServletRequest request) {
        CurrentUser currentUser = new CurrentUser();
        return currentUser;
    }
}
