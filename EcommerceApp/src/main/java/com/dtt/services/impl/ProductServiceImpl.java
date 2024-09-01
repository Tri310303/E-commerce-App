/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.services.impl;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.dtt.pojo.Cart;
import com.dtt.pojo.Product;
import com.dtt.repositories.ProductRepository;
import com.dtt.services.ProductService;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author THIEN TU
 */
@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepo;
    @Autowired
    private Cloudinary cloudinary;

    @Override
    public List<Product> getProducts(Map<String, String> params) {
        return this.productRepo.getProducts(params);
    }

    @Override
    public void addOrUpdate(Product p) {
        try {
            if (!p.getFile().isEmpty()) {
                Map res = this.cloudinary.uploader().upload(p.getFile().getBytes(),
                        ObjectUtils.asMap("resource_type", "auto"));
                p.setImage(res.get("secure_url").toString());
            }
        } catch (IOException ex) {
            System.out.println(ex.getMessage());
        }
        this.productRepo.addOrUpdate(p);
    }

    @Override
    public Product getProductById(int id) {
        return this.productRepo.getProductById(id);
    }

    @Override
    public void deleteProduct(int id) {
        this.productRepo.deleteProduct(id);
    }

    @Override
    public boolean addReceipt(Map<String, Cart> cart) {
        if (cart != null) {
            return this.productRepo.addReceipt(cart);
        }
        return false;
    }

}
