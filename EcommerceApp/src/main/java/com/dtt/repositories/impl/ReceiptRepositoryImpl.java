/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories.impl;

import com.dtt.pojo.Cart;
import com.dtt.pojo.OrderDetail;
import com.dtt.pojo.SaleOrder;
import com.dtt.pojo.User;
import com.dtt.repositories.ProductRepository;
import com.dtt.repositories.ReceiptRepository;
import com.dtt.repositories.UserRepository;
import java.util.Date;
import java.util.Map;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author THIEN TU
 */
@Repository
public class ReceiptRepositoryImpl implements ReceiptRepository {

    @Autowired
    private UserRepository userRepo;
    @Autowired
    private ProductRepository productRepo;
    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean addReceipt(Map<String, Cart> carts) {

        Session s = this.factory.getObject().getCurrentSession();
        SaleOrder order = new SaleOrder();

        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            User u = this.userRepo.getUserByUsername(authentication.getName());
            order.setUserId(u);
            order.setCreatedDate(new Date());
            s.save(u);

            for (Cart c : carts.values()) {
                OrderDetail d = new OrderDetail();
                d.setProductId(this.productRepo.getProductById(c.getId()));
                d.setOrderId(order);
                d.setQuantity(c.getQuantity());
                d.setUnitPrice(c.getPrice());

                s.save(d);
            }

            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
            return false;
        }

    }

}
