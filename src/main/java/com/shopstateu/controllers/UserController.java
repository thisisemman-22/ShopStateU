package com.shopstateu.controllers;

import com.shopstateu.models.User;
import com.shopstateu.services.UserService;
import com.shopstateu.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.HashMap;
import java.util.Map;
import org.springframework.http.HttpStatus;


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
            @RequestParam String college,
            @RequestParam(value = "profilePicture", required = false) MultipartFile profilePicture) {
        logger.debug("Received registration request for email: {}", email);
        try {
            String profilePictureUrl = null;
            if (profilePicture != null && !profilePicture.isEmpty()) {
                // Ensure the writable directory exists
                File uploadDirectory = new File("/tmp/uploads");
                if (!uploadDirectory.exists() && !uploadDirectory.mkdirs()) {
                    logger.error("Failed to create upload directory: /tmp/uploads");
                    return ResponseEntity.status(500).body("Failed to create upload directory");
                }
                String uniqueFilename = java.util.UUID.randomUUID() + "_" + profilePicture.getOriginalFilename();
                File file = new File(uploadDirectory, uniqueFilename);
                profilePicture.transferTo(file);
                profilePictureUrl = "/uploads/" + uniqueFilename;
            }

            User registeredUser = userService.registerUser(fullName, email, password, college, profilePictureUrl);
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

    @PutMapping("/profile-picture")
    public ResponseEntity<?> updateProfilePicture(
            @RequestParam Long userId,
            @RequestParam("profilePicture") MultipartFile profilePicture) {
        try {
            if (profilePicture == null || profilePicture.isEmpty()) {
                return ResponseEntity.badRequest().body("Profile picture is required");
            }

            // Ensure the writable directory exists
            File uploadDirectory = new File("/tmp/uploads");
            if (!uploadDirectory.exists() && !uploadDirectory.mkdirs()) {
                logger.error("Failed to create upload directory: /tmp/uploads");
                return ResponseEntity.status(500).body("Failed to create upload directory");
            }

            // Save the profile picture
            String uniqueFilename = java.util.UUID.randomUUID() + "_" + profilePicture.getOriginalFilename();
            File file = new File(uploadDirectory, uniqueFilename);
            profilePicture.transferTo(file);

            // Generate the public URL using BASE_URL or fallback to Heroku app domain
            String baseUrl = System.getenv("BASE_URL");
            if (baseUrl == null || baseUrl.isEmpty()) {
                baseUrl = "https://shopstateu-89a3d63aed8a.herokuapp.com"; // Fallback for Heroku
            }
            String profilePictureUrl = baseUrl + "/uploads/" + uniqueFilename;

            // Update the user's profile picture in the database
            User updatedUser = userService.updateProfilePicture(userId, profilePictureUrl);
            return ResponseEntity.ok(updatedUser);
        } catch (Exception e) {
            logger.error("Error updating profile picture: {}", e.getMessage());
            return ResponseEntity.status(500).body("An error occurred: " + e.getMessage());
        }
    }

    // Add a new endpoint to serve uploaded files dynamically
    @GetMapping("/uploads/{filename}")
    public ResponseEntity<?> serveFile(@PathVariable String filename) {
        try {
            File file = new File("public/uploads/" + filename);
            if (!file.exists()) {
                return ResponseEntity.status(404).body("File not found");
            }
            return ResponseEntity.ok().body(new org.springframework.core.io.FileSystemResource(file));
        } catch (Exception e) {
            logger.error("Error serving file: {}", e.getMessage());
            return ResponseEntity.status(500).body("An error occurred: " + e.getMessage());
        }
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ResponseBody
    public Map<String, String> handleException(Exception ex) {
        Map<String, String> errorResponse = new HashMap<>();
        errorResponse.put("error", ex.getMessage());
        return errorResponse;
    }
}