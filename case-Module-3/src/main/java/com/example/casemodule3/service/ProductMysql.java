package com.example.casemodule3.service;

import com.example.casemodule3.model.Product;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductMysql implements IProduct {
    private static int noOfRecords;

    public int getNoOfRecords() {
        return noOfRecords;
    }

    public void setNoOfRecords(int noOfRecords) {
        ProductMysql.noOfRecords = noOfRecords;
    }

    private String jdbcURL = "jdbc:mysql://localhost:3306/case_module_3?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "241298";

    private static final String INSERT_PRODUCT_SQL = "INSERT INTO `case_module_3`.`product` (`title`, `id_type`, `price`, `quantity`, `info`, `img`) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_PRODUCT_BY_ID = "SELECT * FROM product WHERE id_product = ?";
    private static final String SELECT_ALL_PRODUCTS = "SELECT * FROM product;";
    private static final String DELETE_PRODUCT_SQL = "DELETE FROM `case_module_3`.`product` WHERE (`id_product` = ?)";
    private static final String SP_DELETE_PRODUCT = "CALL case_module_3.sp_delete_product(?)";
    private static final String SP_UPDATE_PRODUCT_SQL = "CALL case_module_3.sp_update_product(?, ?, ?, ?, ?, ?, ?, ?)";

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
    public void insertProduct(Product product) throws SQLException {
        Connection connection = getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PRODUCT_SQL);
        preparedStatement.setString(1, product.getTitle());
        preparedStatement.setLong(2, product.getIdType());
        preparedStatement.setBigDecimal(3, product.getPrice());
        preparedStatement.setInt(4, product.getQuantity());
        preparedStatement.setString(5, product.getInfo());
        preparedStatement.setString(6, product.getImg());

        System.out.println(this.getClass() + " insertProduct() : " + preparedStatement);

        preparedStatement.execute();
    }

    @Override
    public Product selectProduct(Long id) throws SQLException {
        Connection connection = getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT_BY_ID);
        preparedStatement.setLong(1, id);

        ResultSet rs = preparedStatement.executeQuery();
        System.out.println(this.getClass() + " selectProduct() : " + preparedStatement);

        while (rs.next()) {
            Long idProduct = rs.getLong("id_product");
            String title = rs.getString("title");
            Long idType = Long.parseLong(rs.getString("id_type"));
            BigDecimal price = rs.getBigDecimal("price");
            int quantity = rs.getInt("quantity");
            String info = rs.getString("info");
            String img = rs.getString("img");

            Product product = new Product(idProduct, title, idType, price, quantity, info, img);

            return product;
        }
        return null;
    }

    @Override
    public List<Product> selectAllProduct() throws SQLException {
        List<Product> products = new ArrayList<>();

        Connection connection = getConnection();
        Statement statement = connection.createStatement();

        ResultSet rs = statement.executeQuery(SELECT_ALL_PRODUCTS);
        System.out.println(this.getClass() + " selectAllProduct() : " + statement);

        while (rs.next()) {
            Long id = rs.getLong("id_product");
            String title = rs.getString("title");
            Long idType = Long.parseLong(rs.getString("id_type"));
            BigDecimal price = rs.getBigDecimal("price");
            int quantity = rs.getInt("quantity");
            String info = rs.getString("info");
            String img = rs.getString("img");


            Product product = new Product(id, title, idType, price, quantity, info, img);
            products.add(product);
        }

        return products;
    }

    @Override
    public List<Product> selectProductPage(int offset, int noOfRecords, String search, int idType) throws SQLException {
        List<Product> list = new ArrayList<>();
        Product product = null;
        PreparedStatement preparedStatement = null;
        Connection connection = null;
        try {
            connection = getConnection();
            if (idType != -1) {
                String SELECT_PAGE = "SELECT SQL_CALC_FOUND_ROWS * FROM case_module_3.product WHERE title LIKE ? AND id_type = ? LIMIT " + offset +", " + noOfRecords ;
                preparedStatement = connection.prepareStatement(SELECT_PAGE);
                preparedStatement.setString(1, "%" + search + "%");
                preparedStatement.setInt(2, idType);
            } else {
                String SELECT_PAGE = "SELECT SQL_CALC_FOUND_ROWS * FROM case_module_3.product WHERE title LIKE ? LIMIT " + offset +", " + noOfRecords ;
                preparedStatement = connection.prepareStatement(SELECT_PAGE);
                preparedStatement.setString(1, "%" + search + "%");
            }
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                product = new Product();
                product.setId(rs.getLong("id_product"));
                product.setTitle(rs.getString("title"));
                product.setIdType(Long.parseLong(rs.getString("id_type")));
                product.setPrice(rs.getBigDecimal("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setInfo(rs.getString("info"));
                product.setImg(rs.getString("img"));

                list.add(product);
            }
            rs.close();

            rs = preparedStatement.executeQuery("SELECT FOUND_ROWS()");
            if (rs.next()) {
                this.noOfRecords = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {}
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    @Override
    public void deleteProduct(Long id) throws SQLException {
        Connection connection = getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCT_SQL);
        preparedStatement.setLong(1, id);

        System.out.println(this.getClass() + " deleteProduct() : " + preparedStatement);
        preparedStatement.execute();

        String message = "successfully deleted";
        System.out.println("delete......: " + message);
    }

    public void deleteSp(Long id) throws SQLException {
        Connection connection = getConnection();

        CallableStatement callableStatement = connection.prepareCall(SP_DELETE_PRODUCT);
        callableStatement.setLong(1, id);
        System.out.println(this.getClass() + " deleteSp() : " + callableStatement);

        callableStatement.execute();
    }

    @Override
    public void updateProduct(Long id, Product product) throws SQLException {
        Connection connection = getConnection();

        CallableStatement callableStatement = connection.prepareCall(SP_UPDATE_PRODUCT_SQL);
        callableStatement.setLong(1, id);
        callableStatement.setString(2, product.getTitle());
        callableStatement.setLong(3, product.getIdType());
        callableStatement.setBigDecimal(4, product.getPrice());
        callableStatement.setInt(5, product.getQuantity());
        callableStatement.setString(6, product.getInfo());
        callableStatement.setString(7, product.getImg());


        callableStatement.registerOutParameter(8, Types.VARCHAR);

        System.out.println(this.getClass() + " updateProduct() : " + callableStatement);

        callableStatement.execute();

        String message = callableStatement.getString(8);
    }
}
