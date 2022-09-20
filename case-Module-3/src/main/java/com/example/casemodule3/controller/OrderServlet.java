package com.example.casemodule3.controller;

import com.example.casemodule3.model.OrderDetail;
import com.example.casemodule3.model.Product;
import com.example.casemodule3.model.Type;
import com.example.casemodule3.service.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrderServlet", urlPatterns = "/orders")
public class OrderServlet extends HttpServlet {
    IProduct iProduct;
    IOrder iOrder;
    IType iType;
    List<Type> types;
    List<Product> products;
    List<OrderDetail> orderDetails;
    @Override
    public void init() throws ServletException {
        iProduct = new ProductMysql();
        iOrder = new OrderMysql();
        iType = new TypeMysql();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "order":

                break;
            case "view":
                break;
            case "list":
                break;
            default:
                break;
        }
    }



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "order":
                break;
            default:
                break;
        }
    }

    private void createProduct(HttpServletRequest req, HttpServletResponse resp) {
        List<String> errors = new ArrayList<>();
        types = this.iType.selectAllType();
        OrderDetail orderDetail = new OrderDetail();
        RequestDispatcher requestDispatcher;

    }

}
