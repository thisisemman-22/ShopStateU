package com.shopstateu.controllers;

import com.shopstateu.models.NotificationSettings;
import com.shopstateu.services.NotificationSettingsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/notification-settings")
public class NotificationSettingsController {

    @Autowired
    private NotificationSettingsService notificationSettingsService;

    @GetMapping
    public ResponseEntity<?> getNotificationSettings(Authentication authentication) {
        String username = authentication.getName();
        Optional<NotificationSettings> settings = notificationSettingsService.getNotificationSettingsByUserEmail(username);
        if (settings.isPresent()) {
            return ResponseEntity.ok(settings.get());
        } else {
            return ResponseEntity.status(404).body("Notification settings not found");
        }
    }

    @PutMapping
    public ResponseEntity<?> updateNotificationSettings(Authentication authentication,
            @RequestParam boolean newMessages,
            @RequestParam boolean newComments,
            @RequestParam boolean newOffers,
            @RequestParam boolean exclusiveDeals,
            @RequestParam boolean featureUpdates) {
        String username = authentication.getName();
        NotificationSettings settings = notificationSettingsService.updateNotificationSettingsByUserEmail(username, newMessages, newComments, newOffers, exclusiveDeals, featureUpdates);
        return ResponseEntity.ok(settings);
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