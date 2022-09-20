package com.example.casemodule3.controller;

import com.example.casemodule3.model.OrderDetail;
import com.example.casemodule3.model.Product;
import com.example.casemodule3.model.Type;
import com.example.casemodule3.service.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;


@WebServlet(name = "ProductServlet", urlPatterns = {"/products", ""} )
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ProductServlet extends HttpServlet {
    IProduct iProduct;
    IOrder iOrder;
    IType iType;
    List<Type> types;
    List<Product> products;
    List<OrderDetail> orderDetailList;

    @Override
    public void init() throws ServletException {
        iProduct = new ProductMysql();
        iOrder = new OrderMysql();
        iType = new TypeMysql();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");

            if (action == null) {
                action = "";
            }
            switch (action) {
                case "create":
                    showCreateProductForm(req, resp);
                    break;
                case "edit":
                    showEditProductForm(req, resp);
                case "delete":
                    showDeleteForm(req, resp);
                    break;
                case "view":
                    viewCustomer(req, resp);
                    break;
                case "order":
                    orderInfo(req, resp);
                    break;
                case "orderlist":
//                    listOrderList(req, resp);
                    listOrderPage(req, resp);
                    break;
                case "vieworder":
                    viewInfoOrder(req, resp);
                    break;
                default:
//                    listCustomers(req, resp);
                    listProductPage(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void showCreateProductForm(HttpServletRequest req, HttpServletResponse resp) {
        types = this.iType.selectAllType();
        req.setAttribute("types", types);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/create-product.jsp");
        try {
            requestDispatcher.forward(req, resp);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void showEditProductForm(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        RequestDispatcher requestDispatcher;
        types = this.iType.selectAllType();
        Long id = Long.parseLong(req.getParameter("id"));
        Product product = this.iProduct.selectProduct(id);
        if (product == null) {
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/error-404.jsp");
        } else if (product.getId() != id) {
            req.setAttribute("types", types);
            requestDispatcher = req.getRequestDispatcher("index.jsp");
        } else {
            req.setAttribute("product", product);
            req.setAttribute("types", types);
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/edit-product.jsp");
        }
        requestDispatcher.forward(req, resp);
    }

    private void showDeleteForm(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        types = this.iType.selectAllType();
        Long id = Long.parseLong(req.getParameter("id"));
        Product product = this.iProduct.selectProduct(id);

        RequestDispatcher requestDispatcher;

        if (product == null) {
            requestDispatcher = req.getRequestDispatcher("error-404.jsp");
        } else {
            req.setAttribute("product", product);
            req.setAttribute("types", types);
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/delete-product.jsp");
        }

        try {
            requestDispatcher.forward(req, resp);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void viewCustomer(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        Long id = Long.parseLong(req.getParameter("id"));
        Product product = this.iProduct.selectProduct(id);

        RequestDispatcher requestDispatcher;

        if (product == null) {
            requestDispatcher = req.getRequestDispatcher("error-404.jsp");
        } else {
            req.setAttribute("product", product);
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/view-product.jsp");
        }

        try {
            requestDispatcher.forward(req, resp);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void listCustomers(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        products = this.iProduct.selectAllProduct();
        types = this.iType.selectAllType();
        req.setAttribute("products", products);
        req.setAttribute("types", types);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("index.jsp");
        requestDispatcher.forward(req, resp);
    }

    private void listProductPage(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        types = this.iType.selectAllType();
        int page = 1;
        int recordsPerPage = 5;
        String search = "";
        int idType = -1;

        if (req.getParameter("search") != null) {
            search = req.getParameter("search");
        }

        if (req.getParameter("idType") != null) {
            idType = Integer.parseInt(req.getParameter("idType"));
        }

        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }
        List<Product> products = iProduct.selectProductPage((page - 1) * recordsPerPage, recordsPerPage, search, idType);
        int noOfRecords = iProduct.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
        req.setAttribute("types", types);
        req.setAttribute("products", products);
        req.setAttribute("page", page);
        req.setAttribute("noOfPages", noOfPages);
        req.setAttribute("search", search);
        req.setAttribute("idType", idType);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("index.jsp");
        requestDispatcher.forward(req, resp);
    }

    private void orderInfo(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        RequestDispatcher requestDispatcher;
        types = this.iType.selectAllType();
        Long id = Long.parseLong(req.getParameter("id"));
        Product product = this.iProduct.selectProduct(id);
        BigDecimal price = product.getPrice();

        if (product == null) {
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/error-404.jsp");
        } else if (product.getId() != id) {
            req.setAttribute("types", types);
            requestDispatcher = req.getRequestDispatcher("index.jsp");
        } else {
            req.setAttribute("product", product);
            req.setAttribute("price", price);
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/create-order.jsp");
        }
        requestDispatcher.forward(req, resp);
    }

    private void listOrderList(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        orderDetailList = this.iOrder.selectAllOrder();
        req.setAttribute("orderDetailList", orderDetailList);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/list-order.jsp");
        requestDispatcher.forward(req, resp);
    }

    private void listOrderPage(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        int page = 1;
        int recordsPerPage = 5;
        int date = -1;
        int month = -1;

        if (req.getParameter("date") != null) {
            date = Integer.parseInt(req.getParameter("date"));
        }

        if (req.getParameter("month") != null) {
            month = Integer.parseInt(req.getParameter("month"));
        }

        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }

        List<OrderDetail> orderDetails = iOrder.selectOrderPage((page - 1) * recordsPerPage, recordsPerPage, date, month);
        int noOfRecords = iOrder.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
        req.setAttribute("orderDetails", orderDetails);
        req.setAttribute("page", page);
        req.setAttribute("noOfPages", noOfPages);
        req.setAttribute("date", date);
        req.setAttribute("month", month);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/list-order.jsp");
        requestDispatcher.forward(req, resp);
    }
    private void viewInfoOrder(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        OrderDetail orderDetail = this.iOrder.selectOrder(id);
        Long idProduct = orderDetail.getIdProduct();
        Product product = this.iProduct.selectProduct(idProduct);

        RequestDispatcher requestDispatcher;

        if (product == null) {
            requestDispatcher = req.getRequestDispatcher("error-404.jsp");
        } else {
            req.setAttribute("orderDetail", orderDetail);
            req.setAttribute("product", product);
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/view-order.jsp");
        }
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");

            if (action == null) {
                action = "";
            }
            switch (action) {
                case "create":
                    createProduct(req, resp);
                    break;
                case "edit":
                    updateProduct(req, resp);
                    break;
                case "delete":
                    deleteProduct(req, resp);
                    break;
                case "order":
                    order(req, resp);
                    break;
                default:
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    private void createProduct(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        List<String> errors = new ArrayList<>();
        types = this.iType.selectAllType();
        Product product = new Product();
        RequestDispatcher requestDispatcher;
        try {
            String title = req.getParameter("title");
            product.setTitle(title);
            Long type = Long.parseLong(req.getParameter("type"));
            product.setIdType(type);
            BigDecimal price = new BigDecimal(req.getParameter("price"));
            product.setPrice(price);
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            product.setQuantity(quantity);
            String info = req.getParameter("info");
            product.setInfo(info);
            ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
            Validator validator = validatorFactory.getValidator();
            Set<ConstraintViolation<Product>> constraintViolations = validator.validate(product);

            if (!constraintViolations.isEmpty()) {
                for (ConstraintViolation<Product> item : constraintViolations) {
                    errors.add(item.getMessage());
                }
                req.setAttribute("errors", errors);
                req.setAttribute("product", product);
                req.setAttribute("types", types);
            } else {
                if (iType.selectIdType(type) != null) {
                    for (Part part : req.getParts()) {
                        if (part.getName().equals("file")) {
                            String fileName = extractFileName(part);
                            if (fileName != null && !fileName.isEmpty()) {
                                fileName = new File(fileName).getName();
                                part.write("C:\\Users\\huynd\\OneDrive\\Desktop\\caseModule3\\caseStudy3\\case-Module-3\\src\\main\\webapp\\image\\" + fileName);
                                String server = this.getServletContext().getRealPath("/") + "\\image\\" + fileName;
                                part.write(server);
                                product.setImg("/image/" + fileName);
                            } else {
                                product.setImg("No image product");
                            }
                        }
                    }
                    this.iProduct.insertProduct(product);
                    req.setAttribute("types", types);
                    req.setAttribute("message", "New product was created");
                } else {
                    errors.add("Product type is not available");
                    req.setAttribute("errors", errors);
                    req.setAttribute("product", product);
                    req.setAttribute("types", types);
                }
            }
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/create-product.jsp");
            requestDispatcher.forward(req, resp);
        } catch (NumberFormatException numberFormatException) {
            errors.add("Input format");
            req.setAttribute("errors", errors);
            req.setAttribute("product", product);
            req.setAttribute("types", types);
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/create-product.jsp");
            requestDispatcher.forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {

        List<String> errors = new ArrayList<>();
        types = this.iType.selectAllType();
        RequestDispatcher requestDispatcher;
        Long id = Long.parseLong(req.getParameter("id"));

        Product product = this.iProduct.selectProduct(id);
        if (product == null) {
            requestDispatcher = req.getRequestDispatcher("error-404.jsp");
        } else {
            try {
                String title = req.getParameter("title");
                product.setTitle(title);
                Long type = Long.parseLong(req.getParameter("type"));
                product.setIdType(type);
                BigDecimal price = new BigDecimal(req.getParameter("price"));
                product.setPrice(price);
                int quantity = Integer.parseInt(req.getParameter("quantity"));
                product.setQuantity(quantity);
                String info = req.getParameter("info");
                product.setInfo(info);
                String img = req.getParameter("file");
//                product.setImg(img);

                ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
                Validator validator = validatorFactory.getValidator();
                Set<ConstraintViolation<Product>> constraintViolations = validator.validate(product);

                if (!constraintViolations.isEmpty()) {
                    for (ConstraintViolation<Product> item : constraintViolations) {
                        errors.add(item.getMessage());
                    }
                    req.setAttribute("errors", errors);
                    req.setAttribute("product", product);
                    req.setAttribute("types", types);
                } else {
                    if (iType.selectIdType(type) != null) {
                        for (Part part : req.getParts()) {
                            if (part.getName().equals("file")) {
                                String fileName = extractFileName(part);
                                if (fileName != null && !fileName.isEmpty()) {
                                    fileName = new File(fileName).getName();
                                    part.write("C:\\Users\\huynd\\OneDrive\\Desktop\\caseModule3\\caseStudy3\\case-Module-3\\src\\main\\webapp\\image\\" + fileName);
                                    String server = this.getServletContext().getRealPath("/") + "\\image\\" + fileName;
                                    part.write(server);
                                    product.setImg("/image/" + fileName);
                                } else {
                                    product.setImg("No image product");
                                }
                            }
                        }
                        if (iProduct.selectProduct(id) != null) {
                            this.iProduct.updateProduct(id, product);
                            req.setAttribute("types", types);
                            req.setAttribute("product", product);
                            req.setAttribute("message", "Product information was updated");

                        } else {
                            requestDispatcher = req.getRequestDispatcher("error-404.jsp");
                        }
                    } else {
                        errors.add("Product type is not available");
                        req.setAttribute("errors", errors);
                        req.setAttribute("product", product);
                        req.setAttribute("types", types);
                    }
                }
                requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/edit-product.jsp");
                requestDispatcher.forward(req, resp);

            } catch (NumberFormatException numberFormatException) {
                errors.add("Input format");
                req.setAttribute("errors", errors);
                req.setAttribute("product", product);
                req.setAttribute("types", types);
                requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/edit-product.jsp");
                requestDispatcher.forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        Product product = this.iProduct.selectProduct(id);
        orderDetailList = this.iOrder.selectAllOrder();
        types = this.iType.selectAllType();
        RequestDispatcher requestDispatcher;

        if (product == null) {
            requestDispatcher = req.getRequestDispatcher("error-404.jsp");
        } else {
            for (OrderDetail orderDetail : orderDetailList ) {
                if (orderDetail.getIdProduct().equals(id)) {
                    this.iProduct.deleteSp(id);
                    req.setAttribute("message", "Product was deleted");
                    requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/view-deleted.jsp");
                    requestDispatcher.forward(req, resp);
                }
            }
            this.iProduct.deleteProduct(id);
            req.setAttribute("message", "Product was deleted");
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/view-deleted.jsp");
            requestDispatcher.forward(req, resp);
        }
    }

    private void order(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();
        types = this.iType.selectAllType();
        RequestDispatcher requestDispatcher;

        OrderDetail orderDetail = new OrderDetail();

        try {
            Long idProduct = Long.parseLong(req.getParameter("idProduct"));
            orderDetail.setIdProduct(idProduct);

            BigDecimal productPrice = new BigDecimal(req.getParameter("price"));
            orderDetail.setTotalPrice(productPrice);

            int quantity = Integer.parseInt(req.getParameter("quantity"));
            orderDetail.setQuantity(quantity);

            String customer = req.getParameter("customer");
            orderDetail.setCustomer(customer);

            String address = req.getParameter("address");
            orderDetail.setAddress(address);

            req.setAttribute("errors", errors);
            req.setAttribute("types", types);
            req.setAttribute("orderDetail", orderDetail);
            this.iOrder.insertOrder(orderDetail);
            req.setAttribute("message", "Order thanh cong");

            requestDispatcher = req.getRequestDispatcher("/WEB-INF/view/info-order.jsp");
            requestDispatcher.forward(req, resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    public File getFolderUpload() {
        File folderUpload = new File(System.getProperty("user.home") + "/Uploads");
        if (!folderUpload.exists()) {
            folderUpload.mkdirs();
        }
        return folderUpload;
    }

}
