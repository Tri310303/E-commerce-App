/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories;

import com.dtt.pojo.Store;

import java.util.List;
import java.util.Map;

/**
 *
 * @author THIEN TU
 */
public interface StoreRepository {
    public void addOrUpdate(Store store);
    public boolean deleteStore(int id);
    public List<Store> getStoresByuserId(int userId);
    public Store getStoreById(int id);
    public List<Store> getStore();
}
