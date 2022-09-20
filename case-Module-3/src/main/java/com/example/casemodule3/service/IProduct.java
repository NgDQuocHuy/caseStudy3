package com.example.casemodule3.service;

import com.example.casemodule3.model.Product;

import java.sql.SQLException;
import java.util.List;

public interface IProduct {
    public void insertProduct(Product product) throws SQLException;

    public Product selectProduct(Long id) throws SQLException;

    public List<Product> selectAllProduct() throws SQLException;
    public List<Product> selectProductPage(int offset, int row, String search, int idType) throws SQLException;

    public void deleteProduct(Long id) throws SQLException;

    public void deleteSp(Long id) throws SQLException;

    public void updateProduct(Long id, Product product) throws SQLException;

    int getNoOfRecords();

    void setNoOfRecords(int row);
}
