/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories.impl;

import com.dtt.pojo.Store;
import com.dtt.repositories.StoreRepository;
import com.dtt.repositories.UserRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author THIEN TU
 */
@Repository
@Transactional
@PropertySource("classpath:configs.properties")
public class StoreRepositoryImpl implements StoreRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    public void addOrUpdate(Store store) {
        Session s = this.factory.getObject().getCurrentSession();
        if (store.getId() != null && store.getId() > 0) {
            s.update(store);
        } else {
            s.save(store);
        }
    }


    @Override
    public boolean deleteStore(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        try {
            Store store = session.get(Store.class, id);
            session.delete(store);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public List<Store> getStoresByuserId(int userId) {
        Session session = this.factory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Store> query = builder.createQuery(Store.class);
        Root<Store> root = query.from(Store.class);

        // Tìm kiếm theo userId trong store
        query.select(root).where(builder.equal(root.get("managerId").get("id"), userId));

        return session.createQuery(query).getResultList();
    }

    @Override
    public Store getStoreById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        return session.get(Store.class, id);
    }

    @Override
    public List<Store> getStore() {

        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createNamedQuery("Store.findAll");

        return q.getResultList();
    }

}
