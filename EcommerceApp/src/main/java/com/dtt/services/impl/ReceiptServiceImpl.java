/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.services.impl;

import com.dtt.pojo.Cart;
import com.dtt.repositories.ReceiptRepository;
import com.dtt.services.ReceiptService;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author THIEN TU
 */
@Service
public class ReceiptServiceImpl implements ReceiptService {
    @Autowired
    private ReceiptRepository receiptRepo;

    @Override
    public boolean addReceipt(Map<String, Cart> carts) {
        return this.receiptRepo.addReceipt(carts);
    }
    
}
