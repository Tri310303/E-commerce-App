/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.services.impl;

import com.dtt.pojo.Comment;
import com.dtt.repositories.CommentRepository;
import com.dtt.services.CommentService;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author THIEN TU
 */
@Service
public class CommentServiceImpl implements CommentService {
//    @Autowired
//    private CommentRepository commentRepo;
//    
//    @Override
//    public List<Comment> getComments(int productId) {
//        return this.commentRepo.getComments(productId);
//    }

    @Autowired
    private CommentRepository commentRepo;

    @Override
    public void addComment(Comment comment) {
        this.commentRepo.addComment(comment);
    }

    @Override
    public boolean updateComment(Comment comment) {
        return this.commentRepo.updateComment(comment);
    }

    @Override
    public boolean deleteComment(int id) {
        return this.commentRepo.deleteComment(id);
    }

    @Override
    public List<Comment> getCommentsByproductId(int productId) {
        List<Comment> comments = this.commentRepo.getCommentsByproductId(productId);
        return comments;
    }

    @Override
    public Comment getCommentById(int id) {
        return this.commentRepo.getCommentById(id);

    }
}
