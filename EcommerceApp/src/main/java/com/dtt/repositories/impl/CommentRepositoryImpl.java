/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories.impl;

import com.dtt.pojo.Comment;
import com.dtt.repositories.CommentRepository;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author THIEN TU
 */
@Repository
@Transactional
public class CommentRepositoryImpl implements CommentRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    public void addComment(Comment comment) {
        Session session = this.factory.getObject().getCurrentSession();
        session.save(comment);
    }

    @Override
    public boolean updateComment(Comment comment) {
        Session session = this.factory.getObject().getCurrentSession();
        try {
            session.update(comment);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean deleteComment(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        try {
            Comment comment = session.get(Comment.class, id);
            session.delete(comment);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public List<Comment> getCommentsByproductId(int productId) {
        Session session = this.factory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Comment> query = builder.createQuery(Comment.class);
        Root<Comment> root = query.from(Comment.class);

        // Tìm kiếm theo productId trong Comment, không phải Product
        query.select(root).where(builder.equal(root.get("productId").get("id"), productId));

        return session.createQuery(query).getResultList();
    }

    @Override
    public Comment getCommentById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        return session.get(Comment.class, id);
    }

}
