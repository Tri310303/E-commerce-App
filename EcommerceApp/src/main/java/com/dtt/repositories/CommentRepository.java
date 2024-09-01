/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories;

import com.dtt.pojo.Comment;
import java.util.List;

/**
 *
 * @author THIEN TU
 */
public interface CommentRepository {
    public void addComment(Comment comment);
    public boolean updateComment(Comment comment);
    public boolean deleteComment(int id);
    public List<Comment> getCommentsByproductId(int productId);
    public Comment getCommentById(int id);
}
