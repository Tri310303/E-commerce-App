/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.services;

import com.dtt.pojo.User;
import java.util.List;
import org.springframework.security.core.userdetails.UserDetailsService;

/**
 *
 * @author THIEN TU
 */
public interface UserService extends UserDetailsService {

    User getUserByUsername(String username);

    void addUser(User user);

    boolean authUser(String username, String password);

    // Các phương thức mới
    List<User> getInactiveUsers();

    void updateUserStatus(User user);

    User getUserById(int id);

    public List<User> getUser();
}
