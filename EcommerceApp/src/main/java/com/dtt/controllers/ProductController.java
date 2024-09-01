/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.controllers;

import com.dtt.pojo.Product;
import com.dtt.services.ProductService;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

/**
 *
 * @author THIEN TU
 */
@Controller
public class ProductController {

    @Autowired
    private ProductService prodService;

    @GetMapping("/products")
    public String createView(Model model) {
        model.addAttribute("product", new Product());
        return "products";
    }

    @PostMapping("/products")
    public String createProduct(@ModelAttribute(value = "product") @Valid Product p,
            BindingResult rs) {
        if (!rs.hasErrors()) {
            try {
                this.prodService.addOrUpdate(p);
                return "redirect:/";
            } catch (Exception ex) {
                // Log the exception message
                System.err.println("Exception occurred while adding or updating product: " + ex.getMessage());
                ex.printStackTrace(); // Print stack trace for detailed information
            }
        } else {
            // Log validation errors
            System.err.println("Validation errors occurred:");
            rs.getAllErrors().forEach(error -> {
                System.err.println(error.getDefaultMessage());
            });
        }

        return "products";
    }

    @GetMapping("/products/{productId}")
    public String updateView(Model model, @PathVariable(value = "productId") int id) {
        model.addAttribute("product", this.prodService.getProductById(id));

        return "products";
    }

}
