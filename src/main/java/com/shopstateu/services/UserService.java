package com.shopstateu.services;

import com.shopstateu.models.User;
import com.shopstateu.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserRepository userRepository;

    public User registerUser(String fullName, String email, String password, String college, String profilePictureUrl) {
        logger.debug("Starting user registration for email: {}", email);

        logger.debug("Validating email: {}", email);
        if (!email.endsWith("@g.batstate-u.edu.ph")) {
            logger.error("Email validation failed for: {}", email);
            throw new IllegalArgumentException("Email must end with @g.batstate-u.edu.ph");
        }

        logger.debug("Validating password for email: {}", email);
        if (password.length() < 8 || !password.matches(".*[A-Z].*") || !password.matches(".*[0-9].*")) {
            logger.error("Password validation failed for email: {}", email);
            throw new IllegalArgumentException("Password must be at least 8 characters long, contain an uppercase letter, and a number.");
        }

        logger.debug("Checking if email is already registered: {}", email);
        Optional<User> existingUser = userRepository.findByEmail(email);
        if (existingUser.isPresent()) {
            logger.error("Email already registered: {}", email);
            throw new IllegalArgumentException("Email is already registered.");
        }

        logger.debug("Validation passed for email: {}. Creating user.", email);

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password); // Store password as plain text
        user.setCollege(college);
        user.setProfilePicture(profilePictureUrl);
        user.setCreatedAt(LocalDateTime.now()); // Keep LocalDateTime for database storage

        logger.debug("Saving user to database: {}", email);
        User savedUser = userRepository.save(user);
        logger.debug("User registered successfully with email: {}", email);

        return savedUser;
    }

    public User updateProfilePicture(Long userId, String profilePictureUrl) {
        User user = userRepository.findById(userId).orElseThrow(() -> new IllegalArgumentException("User not found with ID: " + userId));
        user.setProfilePicture(profilePictureUrl);
        return userRepository.save(user);
    }

    public Optional<User> loginUser(String email, String password) {
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent() && user.get().getPassword().equals(password)) { // Compare plain text passwords
            return user;
        }
        return Optional.empty();
    }

    public Optional<User> getUserById(Long userId) {
        return userRepository.findById(userId);
    }
}