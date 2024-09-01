/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.controllers;

import com.dtt.pojo.Store;
import com.dtt.pojo.StoreDTO;
import com.dtt.pojo.User;
import com.dtt.services.StoreService;
import com.dtt.services.UserService;
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
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author THIEN TU
 */
@RestController
@RequestMapping("/api/stores")
@CrossOrigin // Cho phép truy cập từ các domain khác
public class ApiStoreController {

    @Autowired
    private StoreService storeService;
    @Autowired
    private UserService userService;
    
    // Endpoint để thêm cửa hàng
    @PostMapping
    @CrossOrigin
    public ResponseEntity<String> addStore(@RequestParam("manager_id") Integer userId,
                                             @RequestParam("name") String name,
                                             @RequestParam("address") String address,
                                             @RequestParam("phone") String phone,
                                             @RequestParam("email") String email,
                                             @RequestParam(value = "file", required = false) MultipartFile file) {
        try {
            // Kiểm tra các tham số không null hoặc rỗng
            if (   userId == null 
                || name == null || name.trim().isEmpty()
                || address == null || address.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()
                || email == null || email.trim().isEmpty()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Thông tin người dùng khi tạo cửa hàng không hợp lệ");
            }

            // Lấy đối tượng User từ userId
            User userExists = userService.getUserById(userId);
            if (userExists == null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Người dùng không tồn tại");
            }

            Store store = new Store();
            store.setManagerId(userExists); // Gán đối tượng User
            store.setName(name);
            store.setAddress(address);
            store.setPhone(phone);
            store.setEmail(email);

            // Lưu file nếu có
            if (file != null && !file.isEmpty()) {
            }
             // Gọi service để thêm bình luận
            storeService.addOrUpdate(store);

            // Tạo StoreDTO để trả về thông tin đã thêm
            StoreDTO storeDTO = new StoreDTO(store.getId(), store.getName(), store.getAddress(),
                    store.getPhone(), store.getEmail(), store.getManagerId());

            return ResponseEntity.status(HttpStatus.CREATED).body("Thêm cửa hàng thành công");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Thêm cửa hàng thất bại: " + e.getMessage());
        }
    }
    
    
    @GetMapping()
    @CrossOrigin
    public ResponseEntity<List<Store>> list(@RequestParam Map<String, String> params) {
        return new ResponseEntity<>(this.storeService.getStore(), HttpStatus.OK);
    }

}
