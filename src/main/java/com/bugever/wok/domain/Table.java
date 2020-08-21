package com.bugever.wok.domain;

import java.util.*;

public class Table {

    private String name;
    private String comment = "";
    private List<Column> columns = new LinkedList<>();
    private Map<String, Column> nameToColumn = new HashMap<>();
    private Set<String> keys = new HashSet<>();

    public Table(String name) {
        this.name = name;
    }

    public void addColumn(Column column) {
        columns.add(column);
        nameToColumn.put(column.getName(), column);
    }

    public void addKeys(String[] keys) {
        for (String key : keys) {
            this.keys.add(key.trim());
        }
    }

    public String getName() {
        return name;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public List<Column> getColumns() {
        return columns;
    }

    public Set<String> getKeys() {
        return keys;
    }
}
