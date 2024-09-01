/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.services.impl;

import com.cloudinary.Cloudinary;
import com.dtt.pojo.Store;
import com.dtt.repositories.StoreRepository;
import com.dtt.services.StoreService;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author THIEN TU
 */
@Service
public class StoreServiceImpl implements StoreService {

    @Autowired
    private StoreRepository storeRepo;

    @Override
    public void addOrUpdate(Store store) {
        this.storeRepo.addOrUpdate(store);
    }

    @Override
    public boolean deleteStore(int id) {
        return this.storeRepo.deleteStore(id);
    }

    @Override
    public List<Store> getStoresByuserId(int userId) {
        List<Store> stores = this.storeRepo.getStoresByuserId(userId);
        return stores;
    }

    @Override
    public Store getStoreById(int id) {
        return this.storeRepo.getStoreById(id);
    }

    @Override
    public List<Store> getStore() {
        return this.storeRepo.getStore();
    }
}
