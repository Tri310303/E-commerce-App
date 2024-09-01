/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.controllers;

import com.dtt.components.JwtService;
import com.dtt.pojo.User;
import com.dtt.services.UserService;
import java.security.Principal;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
        
/**
 *
 * @author THIEN TU
 */

@Controller
public class UserController {
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    @Autowired
    private UserService userService;
    @Autowired
    private JwtService jwtService;
    
    // Trang đăng ký người dùng
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    // Xử lý đăng ký người dùng mới
    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user, @RequestPart("file") MultipartFile[] file) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setUserRole("ROLE_USER");
        user.setActive(true);
        if (file.length > 0) {
            user.setFile(file[0]);
        }
        
        userService.addUser(user);
        return "redirect:/login";
    }

    // Trang đăng nhập
    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    // Xử lý đăng nhập
    @PostMapping("/login")
    public String loginUser(@RequestParam("username") String username, @RequestParam("password") String password, Model model, HttpServletRequest request) {
        if (userService.authUser(username, password)) {
            String token = jwtService.generateTokenLogin(username);
            request.getSession().setAttribute("token", token);
            return "redirect:/home";
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "login";
        }
    }

    // Trang người dùng hiện tại
    @GetMapping("/current-user")
    public String getCurrentUser(Principal principal, Model model) {
        User user = userService.getUserByUsername(principal.getName());
        model.addAttribute("user", user);
        return "userProfile";
    }

    // Trang xác nhận người dùng
    @GetMapping("/check")
    public String checkUserActive(Model model) {
        model.addAttribute("inactiveUsers",this.userService.getInactiveUsers());
        return "check";
    }

    // Xác nhận người dùng
    @PostMapping("/confirm")
    public String confirmActive(@RequestParam("userId") int userId) {
        User user = userService.getUserById(userId);
        if (user != null && !user.getActive()) {
            user.setActive(true);
            userService.updateUserStatus(user);
        }
        return "redirect:/check";
    }
}
