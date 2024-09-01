/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories.impl;

import com.dtt.pojo.User;
import com.dtt.repositories.UserRepository;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author THIEN TU
 */
@Repository
@Transactional
public class UserRepositoryImpl implements UserRepository {

    @PersistenceContext
    private EntityManager em;

    @Autowired
    private LocalSessionFactoryBean factory;
    @Autowired
    private BCryptPasswordEncoder passEncoder;

    @Override
    public User getUserByUsername(String username) {
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createQuery("FROM User WHERE username = :username");
        q.setParameter("username", username);

        return (User) q.getSingleResult();
    }

    @Override
    public void addUser(User user) {
        Session s = this.factory.getObject().getCurrentSession();
        s.save(user);
    }

    @Override
    public boolean authUser(String username, String password) {
        User u = this.getUserByUsername(username);

        return this.passEncoder.matches(password, u.getPassword());
    }

    @Override
    public List<User> getInactiveUsers() {
        String query = "SELECT u FROM User u WHERE u.active = false";
        return this.em.createQuery(query, User.class).getResultList();
    }

    @Override
    public void updateUserStatus(User user) {
        this.em.merge(user);
    }

    @Override
    public User getUserById(int id) {
        return this.em.find(User.class, id);
    }

    @Override
    public List<User> getUser() {
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createNamedQuery("User.findAll");

        return q.getResultList();
    }

}
