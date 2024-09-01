/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories.impl;

import com.dtt.pojo.Order;
import com.dtt.repositories.OrderRepository;
import java.util.List;
import java.util.Optional;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author asus
 */
@Repository
@Transactional
public class OrderRepositoryImpl  implements OrderRepository{

//    @Autowired
//    private SessionFactory sessionFactory;
//
//    @Override
//    public List<Order> getAllOrders() {
//        Session session = sessionFactory.getCurrentSession();
//        return session.createQuery("FROM Order", Order.class).getResultList();
//    }
//
//    @Override
//    public Optional<Order> getOrderById(Long id) {
//        Session session = sessionFactory.getCurrentSession();
//        return Optional.ofNullable(session.get(Order.class, id));
//    }
//
//    @Override
//    public Order createOrder(Order order) {
//        Session session = sessionFactory.getCurrentSession();
//        session.save(order);
//        return order;
//    }
//
//    @Override
//    public Order updateOrder(Long id, Order order) {
//        Session session = sessionFactory.getCurrentSession();
//        Order existingOrder = session.get(Order.class, id);
//        if (existingOrder != null) {
//            existingOrder.setOrderId(order.getOrderId());
//            existingOrder.setAmount(order.getAmount());
//            existingOrder.setCurrency(order.getCurrency());
//            existingOrder.setStatus(order.getStatus());
//            session.update(existingOrder);
//        }
//        return existingOrder;
//    }
//
//    @Override
//    public void deleteOrder(Long id) {
//        Session session = sessionFactory.getCurrentSession();
//        Order order = session.get(Order.class, id);
//        if (order != null) {
//            session.delete(order);
//        }
//    }
//    
}
