/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.services;

import com.dtt.pojo.Category;
import java.util.List;

/**
 *
 * @author THIEN TU
 */
public interface CategoryService {
    List<Category> getCates();
    Category getCategoryById(int id);
}
