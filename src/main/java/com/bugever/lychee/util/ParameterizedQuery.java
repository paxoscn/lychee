package com.bugever.lychee.util;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class ParameterizedQuery {

    private String sql;
    private List<Object> params;

    public ParameterizedQuery(String sql, Object... params) {
        this.sql = sql;
        this.params = new LinkedList<>(Arrays.asList(params));
    }

    public void replace(String placeholder, String replacement, Object... params) {
        String oldSql = sql;
        sql = sql.replace("{" + placeholder + "}", replacement);
        if (sql.equals(oldSql)) {
            throw new IllegalArgumentException("Replacing failed as {" + placeholder + "} not found." +
                    " Have you already replaced it with something else ?");
        }
        this.params.addAll(Arrays.asList(params));
    }

    public String sql() {
        return sql.replaceAll("\\{[a-zA-Z\\._\\-]+\\}", "");
    }

    public Object[] params() {
        return params.toArray();
    }
}
