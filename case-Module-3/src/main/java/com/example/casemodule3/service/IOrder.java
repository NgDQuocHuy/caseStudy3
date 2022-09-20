package com.example.casemodule3.service;

import com.example.casemodule3.model.OrderDetail;
import com.example.casemodule3.model.Product;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public interface IOrder {
    public void insertOrder(OrderDetail orderDetail) throws SQLException;

    public List<OrderDetail> selectAllOrder() throws SQLException;

    public List<OrderDetail> selectOrderPage(int offset, int noOfRecords, int date, int month) throws SQLException;

    public OrderDetail selectOrder(Long id) throws SQLException;

    public void deleteOrder(Long idProduct) throws SQLException;

    int getNoOfRecords();

    public void setNoOfRecords(int noOfRecords);
}
