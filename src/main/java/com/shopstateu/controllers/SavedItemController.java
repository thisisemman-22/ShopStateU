package com.shopstateu.controllers;

import com.shopstateu.models.SavedItem;
import com.shopstateu.services.SavedItemService;
import com.shopstateu.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/saved-items")
public class SavedItemController {

    @Autowired
    private SavedItemService savedItemService;

    @Autowired
    private ProductRepository productRepository;

    @GetMapping
    public ResponseEntity<?> getSavedItems(Authentication authentication) {
        String username = authentication.getName();
        List<SavedItem> savedItems = savedItemService.getSavedItemsByUserEmail(username);

        // Fetch product details for each saved item
        List<Map<String, Object>> savedItemsWithDetails = savedItems.stream().map(savedItem -> {
            Map<String, Object> itemDetails = new HashMap<>();
            itemDetails.put("savedItem", savedItem);
            productRepository.findById(savedItem.getProductId()).ifPresent(product -> {
                Map<String, Object> productData = new LinkedHashMap<>();
                productData.put("id", product.getId());
                productData.put("name", product.getName());
                productData.put("description", product.getDescription());
                productData.put("category", product.getCategory());
                productData.put("price", product.getPrice());
                productData.put("imagePaths", product.getImagePaths() != null ? List.of(product.getImagePaths().split(",")) : List.of());
                productData.put("sellerName", product.getSellerName());
                productData.put("sellerCollege", product.getSellerCollege());
                productData.put("userId", product.getUser().getId());
                productData.put("postedDate", product.getPostedDate());
                itemDetails.put("product", productData);
            });
            return itemDetails;
        }).collect(Collectors.toList());

        return ResponseEntity.ok(savedItemsWithDetails);
    }

    @PostMapping
    public ResponseEntity<?> saveItem(Authentication authentication, @RequestParam Long productId) {
        String username = authentication.getName();

        // Check if the item is already saved
        if (savedItemService.isItemAlreadySaved(username, productId)) {
            return ResponseEntity.badRequest().body("Item is already saved");
        }

        SavedItem savedItem = savedItemService.saveItemByUserEmail(username, productId);
        return ResponseEntity.ok(savedItem);
    }

    @DeleteMapping
    public ResponseEntity<?> unsaveItem(Authentication authentication, @RequestParam Long productId) {
        String username = authentication.getName();
        savedItemService.unsaveItemByUserEmail(username, productId);
        return ResponseEntity.ok("Item unsaved successfully");
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