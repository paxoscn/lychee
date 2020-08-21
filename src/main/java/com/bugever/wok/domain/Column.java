package com.bugever.wok.domain;

public class Column {

    private String name;
    private String type;
    private String comment;

    public Column(String name, String type, String comment) {
        this.name = name;
        this.type = type;
        this.comment = comment;
    }

    public String getName() {
        return name;
    }

    public String getType() {
        return type;
    }

    public String getComment() {
        return comment;
    }
}
