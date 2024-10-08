/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.controllers;

import com.dtt.pojo.Cart;
import com.dtt.services.ProductService;
import com.dtt.utils.Utils;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author THIENTU
 */
@RestController
@RequestMapping("/api")
public class ApiCartController {
    @Autowired
    private ProductService productService;
    
    @PostMapping(value = "/cart")
    public ResponseEntity<Map<String, String>> addToCart(@RequestBody Cart c, HttpSession session) {
        Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute("cart");
        if (cart == null)
            cart = new HashMap<>();
        
        if (cart.containsKey(c.getId()) == true) {
           Cart t = cart.get(c.getId());
           t.setQuantity(t.getQuantity() + 1);
        } else {
            cart.put(c.getId(), c);
        }
        
        session.setAttribute("cart", cart);
        
        return new ResponseEntity<>(Utils.cartStats(cart), HttpStatus.OK);
    }
    
    @PutMapping(path = "/cart/{productId}", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> updateItemCart(@PathVariable(value = "productId") int id, 
            @RequestBody Map<String, Integer> params, HttpSession session) {
        Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute("cart");
        if (cart != null && cart.containsKey(id)) {
            Cart c = cart.get(id);
            c.setQuantity(params.get("quantity"));
        }
        
        session.setAttribute("cart", cart);
        
        return new ResponseEntity<>(Utils.cartStats(cart), HttpStatus.OK);
    }
    
    @DeleteMapping(path = "/cart/{productId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> deleteItemCart(@PathVariable(value = "productId") int id, HttpSession session) {
        Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute("cart");
        if (cart != null && cart.containsKey(id))
            cart.remove(id);
        
        session.setAttribute("cart", cart);
        
        return new ResponseEntity<>(Utils.cartStats(cart), HttpStatus.OK);
    }
    
    @PostMapping("/pay")
    public ResponseEntity pay(HttpSession session) {
        if (this.productService.addReceipt((Map<String, Cart>) session.getAttribute("cart"))) {
            session.removeAttribute("cart");
            return new ResponseEntity(HttpStatus.OK);
        }
        
        return new ResponseEntity(HttpStatus.BAD_REQUEST);
    }
}
