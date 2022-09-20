package com.example.casemodule3.service;

import com.example.casemodule3.model.Type;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TypeMysql implements IType{
    private String jdbcURL = "jdbc:mysql://localhost:3306/case_module_3?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "241298";

    private static final String SELECT_ALL_IDTYPE = "SELECT * FROM case_module_3.type_product";
    private static final String TYPE_BY_ID = "SELECT * FROM case_module_3.type_product WHERE id_type = ?";
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return connection;
    }

    @Override
    public List<Type> selectAllType() {
        List<Type> list = new ArrayList<>();
        Connection connection = getConnection();
        try{
            Statement statement = connection.createStatement();

            System.out.println(this.getClass() + " selectAllType : " + statement);
            ResultSet rs = statement.executeQuery(SELECT_ALL_IDTYPE);
            while (rs.next()){
                Long idType = rs.getLong("id_type");
                String typ = rs.getString("type");


                Type type = new Type(idType, typ);
                list.add(type);
            }
            connection.close();
        }catch (SQLException sqlException){

        }
        return list;
    }

    @Override
    public Type selectIdType(Long idType) throws SQLException {


        Connection connection = getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(TYPE_BY_ID);
        preparedStatement.setLong(1, idType);

        System.out.println(this.getClass() + " selectIdType : " + preparedStatement);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            Long idType1 = rs.getLong("id_type");
            String typ = rs.getString("type");


            Type type = new Type(idType1, typ);
            return type;
        }
        return null;
    }
}
