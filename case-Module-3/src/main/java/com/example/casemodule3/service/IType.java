package com.example.casemodule3.service;

import com.example.casemodule3.model.Type;

import java.sql.SQLException;
import java.util.List;

public interface IType {
    public List<Type> selectAllType();

    public Type selectIdType(Long idType) throws SQLException;
}
