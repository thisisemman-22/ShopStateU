package com.shopstateu.services;

import com.shopstateu.models.NotificationSettings;
import com.shopstateu.models.User;
import com.shopstateu.repositories.NotificationSettingsRepository;
import com.shopstateu.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class NotificationSettingsService {

    @Autowired
    private NotificationSettingsRepository notificationSettingsRepository;

    @Autowired
    private UserRepository userRepository;

    public Optional<NotificationSettings> getNotificationSettingsByUserId(Long userId) {
        return notificationSettingsRepository.findByUserId(userId);
    }

    public NotificationSettings saveNotificationSettings(NotificationSettings settings) {
        return notificationSettingsRepository.save(settings);
    }

    public Optional<NotificationSettings> getNotificationSettingsByUserEmail(String email) {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new IllegalArgumentException("User not found"));
        return notificationSettingsRepository.findByUserId(user.getId());
    }

    public NotificationSettings updateNotificationSettingsByUserEmail(String email, boolean newMessages, boolean newComments, boolean newOffers, boolean exclusiveDeals, boolean featureUpdates) {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new IllegalArgumentException("User not found"));
        NotificationSettings settings = notificationSettingsRepository.findByUserId(user.getId()).orElse(new NotificationSettings());
        settings.setUserId(user.getId());
        settings.setNewMessages(newMessages);
        settings.setNewComments(newComments);
        settings.setNewOffers(newOffers);
        settings.setExclusiveDeals(exclusiveDeals);
        settings.setFeatureUpdates(featureUpdates);
        return notificationSettingsRepository.save(settings);
    }
}