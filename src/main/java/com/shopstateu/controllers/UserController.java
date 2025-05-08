package com.shopstateu.controllers;

import com.shopstateu.models.User;
import com.shopstateu.services.UserService;
import com.shopstateu.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;

    // Add logger instance
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(
            @RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String college) {
        logger.debug("Received registration request for email: {}", email);
        try {
            User registeredUser = userService.registerUser(fullName, email, password, college);
            logger.debug("User registered successfully: {}", registeredUser.getEmail());
            return ResponseEntity.ok(registeredUser);
        } catch (IllegalArgumentException e) {
            logger.error("Registration failed: {}", e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (Exception e) {
            logger.error("Unexpected error during registration: {}", e.getMessage());
            return ResponseEntity.status(500).body("An unexpected error occurred: " + e.getMessage());
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(
            @RequestParam String email,
            @RequestParam String password) {
        Optional<User> user = userService.loginUser(email, password);
        if (user.isPresent()) {
            String token = jwtUtil.generateToken(user.get().getEmail());
            Map<String, Object> response = new HashMap<>();
            response.put("token", "Bearer " + token);
            response.put("userId", user.get().getId());
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.status(401).body("Invalid email or password");
        }
    }

    @GetMapping("/me")
    public ResponseEntity<?> getCurrentUserProfile() {
        return ResponseEntity.badRequest().body("The /me endpoint has been deprecated. Please use /profile/{userId} instead.");
    }

    @GetMapping("/profile/{userId}")
    public ResponseEntity<?> getUserProfile(@PathVariable Long userId) {
        logger.debug("Received request to fetch profile for user ID: {}", userId);
        Optional<User> user = userService.getUserById(userId);
        if (user.isPresent()) {
            logger.debug("User found for ID: {}", userId);
            return ResponseEntity.ok(user.get());
        } else {
            logger.warn("User not found for ID: {}", userId);
            return ResponseEntity.status(404).body("User not found");
        }
    }

    @GetMapping("/profile")
    public ResponseEntity<?> getUserProfileById(@RequestParam Long id) {
        logger.debug("Received request to fetch profile for user ID: {}", id);
        Optional<User> user = userService.getUserById(id);
        if (user.isPresent()) {
            logger.debug("User found for ID: {}", id);
            return ResponseEntity.ok(user.get());
        } else {
            logger.warn("User not found for ID: {}", id);
            return ResponseEntity.status(404).body("User not found");
        }
    }
}