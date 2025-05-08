package com.shopstateu.services;

import com.shopstateu.models.SavedItem;
import com.shopstateu.models.User;
import com.shopstateu.repositories.SavedItemRepository;
import com.shopstateu.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SavedItemService {

    @Autowired
    private SavedItemRepository savedItemRepository;

    @Autowired
    private UserRepository userRepository;

    public List<SavedItem> getSavedItemsByUserId(Long userId) {
        return savedItemRepository.findByUserId(userId);
    }

    public SavedItem saveItem(Long userId, Long productId) {
        SavedItem savedItem = new SavedItem();
        savedItem.setUserId(userId);
        savedItem.setProductId(productId);
        return savedItemRepository.save(savedItem);
    }

    @Transactional
    public void unsaveItem(Long userId, Long productId) {
        savedItemRepository.deleteByUserIdAndProductId(userId, productId);
    }

    public List<SavedItem> getSavedItemsByUserEmail(String email) {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new IllegalArgumentException("User not found"));
        return savedItemRepository.findByUserId(user.getId());
    }

    public SavedItem saveItemByUserEmail(String email, Long productId) {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new IllegalArgumentException("User not found"));
        return saveItem(user.getId(), productId);
    }

    @Transactional
    public void unsaveItemByUserEmail(String email, Long productId) {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new IllegalArgumentException("User not found"));
        savedItemRepository.deleteByUserIdAndProductId(user.getId(), productId);
    }

    public boolean isItemAlreadySaved(String email, Long productId) {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new IllegalArgumentException("User not found"));
        return savedItemRepository.existsByUserIdAndProductId(user.getId(), productId);
    }
}