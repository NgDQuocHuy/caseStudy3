package com.example.casemodule3.service;

import com.example.casemodule3.model.OrderDetail;
import com.example.casemodule3.model.Product;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderMysql implements IOrder{
    private static int noOfRecords;

    @Override
    public int getNoOfRecords() {
        return noOfRecords;
    }

    @Override
    public void setNoOfRecords(int noOfRecords) {
        OrderMysql.noOfRecords = noOfRecords;
    }

    private String jdbcURL = "jdbc:mysql://localhost:3306/case_module_3?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "241298";

    private static final String INSERT_ORDER_SQL = "CALL case_module_3.sp_order(?, ?, ?, ?, ?, ?, ?);";
    private static final String SELECT_ALL_ORDER = "SELECT * FROM case_module_3.order_detail";
    private static final String SELECT_ORDER_BY_ID = "SELECT * FROM case_module_3.order_detail WHERE id_order = ?";
    private static final String DELETE_BY_ID_PRODUCT = "DELETE FROM `case_module_3`.`order_detail` WHERE (`id_order` = ?)";


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
    public void insertOrder(OrderDetail orderDetail) throws SQLException {
        Connection connection = getConnection();
        CallableStatement callableStatement = connection.prepareCall(INSERT_ORDER_SQL);
        callableStatement.setLong(1, orderDetail.getIdProduct());
        callableStatement.setInt(2, orderDetail.getQuantity());
        callableStatement.setBigDecimal(3, orderDetail.getTotalPrice());
        callableStatement.setDate(4, Date.valueOf(LocalDate.now()));
        callableStatement.setString(5, orderDetail.getCustomer());
        callableStatement.setString(6, orderDetail.getCustomer());


        callableStatement.registerOutParameter(7, Types.VARCHAR);

        System.out.println(this.getClass() + " insertProduct() : " + callableStatement);

        callableStatement.execute();

        String message = callableStatement.getString(7);
        System.out.println("update......: " + message);
    }

    @Override
    public List<OrderDetail> selectAllOrder() throws SQLException {
        List<OrderDetail> orderDetails = new ArrayList<>();

        Connection connection = getConnection();
        Statement statement = connection.createStatement();

        ResultSet rs = statement.executeQuery(SELECT_ALL_ORDER);
        System.out.println(this.getClass() + " selectAllOrder() : " + statement);

        while (rs.next()) {
            Long idOrder = rs.getLong("id_order");
            Long idProduct= rs.getLong("id_product");
            int quantity = rs.getInt("quantity");
            BigDecimal totalPrice = rs.getBigDecimal("total_price");
            Date timeCreat = rs.getDate("time_creat");
            String customer = rs.getString("customer");
            String address = rs.getString("address");

            OrderDetail orderDetail = new OrderDetail(idOrder, idProduct, quantity, totalPrice, timeCreat, customer, address);
            orderDetails.add(orderDetail);
        }

        return orderDetails;
    }

    @Override
    public List<OrderDetail> selectOrderPage(int offset, int noOfRecords, int date, int month) throws SQLException {
        List<OrderDetail> listOrder = new ArrayList<>();
        OrderDetail orderDetail = null;
        PreparedStatement preparedStatement = null;
        Connection connection = null;
        try {
            connection = getConnection();
            if (date != -1 && month != -1) {
                String SELECT_PAGE_ORDER = "SELECT SQL_CALC_FOUND_ROWS * FROM case_module_3.order_detail WHERE time_creat LIKE ? LIMIT " + offset + ", " + noOfRecords;
                preparedStatement = connection.prepareStatement(SELECT_PAGE_ORDER);
                preparedStatement.setString(1, "%" + month + "-" + date + "%");
            } else if (date != -1 && month == -1) {
                String SELECT_PAGE_ORDER = "SELECT SQL_CALC_FOUND_ROWS * FROM case_module_3.order_detail WHERE time_creat LIKE ? LIMIT " + offset + ", " + noOfRecords;
                preparedStatement = connection.prepareStatement(SELECT_PAGE_ORDER);
                preparedStatement.setString(1, "%" + date + "%");
            } else if (date == 1 && month != -1) {
                String SELECT_PAGE_ORDER = "SELECT SQL_CALC_FOUND_ROWS * FROM case_module_3.order_detail WHERE time_creat LIKE ? LIMIT " + offset + ", " + noOfRecords;
                preparedStatement = connection.prepareStatement(SELECT_PAGE_ORDER);
                preparedStatement.setString(1, "%" + month + "%");
            } else {
                String SELECT_PAGE_ORDER = "SELECT SQL_CALC_FOUND_ROWS * FROM case_module_3.order_detail WHERE time_creat LIKE ? LIMIT " + offset + ", " + noOfRecords;
                preparedStatement = connection.prepareStatement(SELECT_PAGE_ORDER);
                preparedStatement.setString(1, "%" + "" + "%");
            }
            ResultSet rs = preparedStatement.executeQuery();
            System.out.println("hhhhhh"+preparedStatement);
            while (rs.next()) {
                orderDetail = new OrderDetail();
                orderDetail.setIdOrder(rs.getLong("id_order"));
                orderDetail.setIdProduct(rs.getLong("id_product"));
                orderDetail.setQuantity(rs.getInt("quantity"));
                orderDetail.setTotalPrice(rs.getBigDecimal("total_price"));
                orderDetail.setTimeCreat(rs.getDate("time_creat"));
                orderDetail.setCustomer(rs.getString("customer"));
                orderDetail.setAddress(rs.getString("address"));

                listOrder.add(orderDetail);
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
        return listOrder;
    }

    @Override
    public OrderDetail selectOrder(Long id) throws SQLException {
        Connection connection = getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ORDER_BY_ID);
        preparedStatement.setLong(1, id);

        ResultSet rs = preparedStatement.executeQuery();
        System.out.println(this.getClass() + " selectOrder() : " + preparedStatement);

        while (rs.next()) {
            Long idOrder = rs.getLong("id_order");
            Long idProduct= rs.getLong("id_product");
            int quantity = rs.getInt("quantity");
            BigDecimal totalPrice = rs.getBigDecimal("total_price");
            Date timeCreat = rs.getDate("time_creat");
            String customer = rs.getString("customer");
            String address = rs.getString("address");

            OrderDetail orderDetail = new OrderDetail(idOrder, idProduct, quantity, totalPrice, timeCreat, customer, address);

            return orderDetail;
        }
        return null;
    }

    @Override
    public void deleteOrder(Long idProduct) throws SQLException {
        Connection connection = getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(DELETE_BY_ID_PRODUCT);
        preparedStatement.setLong(1, idProduct);

        System.out.println(this.getClass() + " deleteProduct() : " + preparedStatement);
        preparedStatement.execute();

        String message = "successfully deleted";
        System.out.println("delete......: " + message);
    }

}
