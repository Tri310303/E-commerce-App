/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.controllers;

import com.dtt.pojo.Category;
import com.dtt.pojo.Product;
import static com.dtt.pojo.Product_.categoryId;
import static com.dtt.pojo.Product_.storeId;
import com.dtt.pojo.Store;
import com.dtt.repositories.CategoryRepository;
import com.dtt.repositories.StoreRepository;
import com.dtt.services.ProductService;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author THIEN TU
 */
@RestController
@RequestMapping("/api")
@CrossOrigin // Cho phép truy cập từ các domain khác
public class ApiProductController {

    @Autowired
    private ProductService prodService;
    @Autowired
    private CategoryRepository categoryRepository; // Inject Category repository

    @Autowired
    private StoreRepository storeRepository; // Inject Store repository

    @DeleteMapping("/products/{productId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(Model model, @PathVariable(value = "productId") int id) {
        this.prodService.deleteProduct(id);
    }

    @GetMapping("/products/")
    @CrossOrigin
    public ResponseEntity<List<Product>> list(@RequestParam Map<String, String> params) {
        return new ResponseEntity<>(this.prodService.getProducts(params), HttpStatus.OK);
    }

    @GetMapping(path = "/products/{productId}/", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Product> retrieve(@PathVariable(value = "productId") int id) {
        Product product = this.prodService.getProductById(id);
        if (product != null && product.getStoreId() != null) { // Kiểm tra store_id không null
            // Lấy tên cửa hàng từ đối tượng khóa ngoại store_id
            String storeName = product.getStoreId().getName();
            // Cập nhật lại tên cửa hàng vào đối tượng Product trước khi trả về
            product.setStore_name(storeName);
            return new ResponseEntity<>(product, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(path = "/products/", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @ResponseStatus(HttpStatus.CREATED)
    public void createProduct(
            @RequestParam("name") String name,
            @RequestParam("price") Long price,
            @RequestParam("manufacturer") String manufacturer,
            @RequestParam("category_id") Integer categoryId,
            @RequestParam("store_id") Integer storeId,
            @RequestPart MultipartFile[] file) {

        // Lấy đối tượng Category và Store từ Repository
        Category category = categoryRepository.getCategoryById(categoryId);
        if (category == null) {
            throw new RuntimeException("Không tìm thấy Category với ID: " + categoryId);
        }

        Store store = storeRepository.getStoreById(storeId);
        if (store == null) {
            throw new RuntimeException("Không tìm thấy Store với ID: " + storeId);
        }

        // Tạo đối tượng Product và đặt các thuộc tính
        Product product = new Product();
        product.setName(name);
        product.setPrice(price);
        product.setManufacturer(manufacturer);
        product.setCategoryId(category);
        product.setStoreId(store);


        // Gọi ProductService để thêm hoặc cập nhật sản phẩm vào cơ sở dữ liệu
        this.prodService.addOrUpdate(product);
    }
}
