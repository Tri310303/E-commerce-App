/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories;

import com.dtt.pojo.Cart;
import java.util.Map;

/**
 *
 * @author THIEN TU
 */
public interface ReceiptRepository {
    boolean addReceipt(Map<String, Cart> carts);
}
