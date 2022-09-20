package com.example.casemodule3.model;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.*;
import java.math.BigDecimal;

public class Product {
    private Long id;
    private String title;
    private Long idType;
    private BigDecimal price;
    private int quantity;
    private String info;
    private String img;

    public Product() {}

    public Product(String title, Long idType, BigDecimal price, int quantity, String info, String img) {
        this.title = title;
        this.idType = idType;
        this.price = price;
        this.quantity = quantity;
        this.info = info;
        this.img = img;
    }

    public Product(Long id, String title, Long idType, BigDecimal price, int quantity, String info, String img) {
        this.id = id;
        this.title = title;
        this.idType = idType;
        this.price = price;
        this.quantity = quantity;
        this.info = info;
        this.img = img;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @NotEmpty(message = "Name cannot be blank")
    @Length (min = 1, max = 30, message = "Name must be more than 1 and less than 45 characters")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @NotNull(message = "Type cannot be Null")
    @Min(value = 1, message = "Id of type not found")
    @Max(value = 5, message = "Id of type not found")
    public Long getIdType() {
        return idType;
    }

    public void setIdType(Long idType) {
        this.idType = idType;
    }


    @NotNull(message = "Price cannot be Null")
    @DecimalMin(value = "1000",message = "Money must be more than 1000")
    @DecimalMax(value = "100000000", message = "Money must be less than 100000000")
    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }


    @NotNull(message = "Quantity cannot be blank")
    @Min(value = 1, message = "Quantity must be more than 1")
    @Max(value = 100, message = "Quantity must be less than 100")
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Length (max = 200, message = "Infomation must be less than 200 characters")
    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
}
