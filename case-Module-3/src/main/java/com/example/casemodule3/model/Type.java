package com.example.casemodule3.model;

public class Type {
    private Long idType;
    private String type;

    public Type() {}

    public Type(Long idType, String type) {
        this.idType = idType;
        this.type = type;
    }

    public Long getIdType() {
        return idType;
    }

    public void setIdType(Long idType) {
        this.idType = idType;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
