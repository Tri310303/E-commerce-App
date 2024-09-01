/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.controllers;

import com.dtt.pojo.Store;
import com.dtt.services.StoreService;
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
public class StoreController {

    @Autowired
    private StoreService storeService;

    @GetMapping("/stores")
    public String createView(Model model) {
        model.addAttribute("store", new Store());
        return "stores";
    }

    @PostMapping("/stores")
    public String createStore(@ModelAttribute(value = "store") @Valid Store s,
            BindingResult rs) {
        if (!rs.hasErrors()) {
            try {
                this.storeService.addOrUpdate(s);
                return "redirect:/index2";
            } catch (Exception ex) {
                System.err.println(ex.getMessage());
            }
        }

        return "stores";
    }

    @GetMapping("/stores/{storeId}")
    public String updateView(Model model, @PathVariable(value = "storeId") int id) {
        model.addAttribute("store", this.storeService.getStoreById(id));

        return "stores";
    }

    @GetMapping("/index2")
    public String showIndex2(Model model) {
        model.addAttribute("stores", this.storeService.getStore());
        return "index2";
    }

}
