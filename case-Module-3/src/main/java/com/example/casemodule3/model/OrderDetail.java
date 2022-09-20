package com.example.casemodule3.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

public class OrderDetail {
    private Long idOrder;
    private Long idProduct;
    private int quantity;

    private BigDecimal totalPrice;

    private Date timeCreat;

    private String customer;

    private String address;

    public OrderDetail() {}

    public OrderDetail(Long idProduct, int quantity, BigDecimal totalPrice, String address) {
        this.idProduct = idProduct;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.address = address;
    }

    public OrderDetail(Long idProduct, int quantity, BigDecimal totalPrice, Date timeCreat, String customer, String address) {
        this.idProduct = idProduct;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.timeCreat = timeCreat;
        this.customer = customer;
        this.address = address;
    }

    public OrderDetail(Long idOrder, Long idProduct, int quantity, BigDecimal totalPrice, Date timeCreat, String customer, String address) {
        this.idOrder = idOrder;
        this.idProduct = idProduct;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.timeCreat = timeCreat;
        this.customer = customer;
        this.address = address;
    }

    public Long getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(Long idOrder) {
        this.idOrder = idOrder;
    }

    public Long getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(Long idProduct) {
        this.idProduct = idProduct;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getTimeCreat() {
        return timeCreat;
    }

    public void setTimeCreat(Date timeCreat) {
        this.timeCreat = timeCreat;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
