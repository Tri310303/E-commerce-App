package com.dtt.pojo;

import java.util.Date;

public class CommentDTO {

    private Integer id;
    private String content;
    private Date createdDate;
    private Product product; // Product được trả về
    private User user; // User được trả về

    public CommentDTO() {
    }

    public CommentDTO(Integer id, String content, Date createdDate, Product product, User user) {
        this.id = id;
        this.content = content;
        this.createdDate = createdDate;
        this.product = product;
        this.user = user;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
