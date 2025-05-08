package com.shopstateu.models;

import jakarta.persistence.*;

@Entity
@Table(name = "notification_settings")
public class NotificationSettings {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private Long userId;

    @Column(nullable = false)
    private boolean newMessages;

    @Column(nullable = false)
    private boolean newComments;

    @Column(nullable = false)
    private boolean newOffers;

    @Column(nullable = false)
    private boolean exclusiveDeals;

    @Column(nullable = false)
    private boolean featureUpdates;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public boolean isNewMessages() {
        return newMessages;
    }

    public void setNewMessages(boolean newMessages) {
        this.newMessages = newMessages;
    }

    public boolean isNewComments() {
        return newComments;
    }

    public void setNewComments(boolean newComments) {
        this.newComments = newComments;
    }

    public boolean isNewOffers() {
        return newOffers;
    }

    public void setNewOffers(boolean newOffers) {
        this.newOffers = newOffers;
    }

    public boolean isExclusiveDeals() {
        return exclusiveDeals;
    }

    public void setExclusiveDeals(boolean exclusiveDeals) {
        this.exclusiveDeals = exclusiveDeals;
    }

    public boolean isFeatureUpdates() {
        return featureUpdates;
    }

    public void setFeatureUpdates(boolean featureUpdates) {
        this.featureUpdates = featureUpdates;
    }
}