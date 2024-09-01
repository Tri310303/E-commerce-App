/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.controllers;

import com.dtt.services.CategoryService;
import com.dtt.services.ProductService;
import com.dtt.services.StoreService;
import com.dtt.services.UserService;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author THIEN TU
 */
@Controller
@ControllerAdvice
public class IndexController {
    @Autowired
    private CategoryService cateService;
    @Autowired
    private ProductService prodService;
    @Autowired
    private StoreService storeService;
    @Autowired
    private UserService UserService;
    
    @ModelAttribute
    public void commonAttr(Model model) {
        model.addAttribute("categories", this.cateService.getCates());
        model.addAttribute("stores", this.storeService.getStore());
        model.addAttribute("users", this.UserService.getUser());
    }
    
    
    @RequestMapping("/")
    public String index(Model model,
            @RequestParam Map<String, String> params) {
        
        model.addAttribute("products", this.prodService.getProducts(params));
        return "index";
    }
}
