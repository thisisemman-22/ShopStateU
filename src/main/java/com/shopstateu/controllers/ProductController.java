package com.shopstateu.controllers;

import com.shopstateu.models.Product;
import com.shopstateu.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.HashMap;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Value("${UPLOAD_DIR:uploads}")
    private String uploadDir;

    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @GetMapping
    public ResponseEntity<List<Map<String, Object>>> getAllProducts() {
        List<Product> products = productService.getAllProducts();
        List<Map<String, Object>> response = products.stream().map(product -> {
            Map<String, Object> productData = new LinkedHashMap<>();
            productData.put("id", product.getId());
            productData.put("name", product.getName());
            productData.put("description", product.getDescription());
            productData.put("category", product.getCategory());
            productData.put("price", product.getPrice());
            productData.put("imagePath", product.getImagePaths() != null ? product.getImagePaths().split(",")[0] : null);
            productData.put("sellerName", product.getSellerName());
            productData.put("sellerCollege", product.getSellerCollege());
            productData.put("userId", product.getUser().getId());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd hh:mm a");
            productData.put("postedDate", product.getPostedDate().format(formatter));
            return productData;
        }).collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/category")
    public ResponseEntity<List<Map<String, Object>>> getProductsByCategory(@RequestParam String category) {
        List<Product> products = productService.getProductsByCategory(category);
        List<Map<String, Object>> response = products.stream().map(product -> {
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
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd hh:mm a");
            productData.put("postedDate", product.getPostedDate().format(formatter));
            return productData;
        }).collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/my-listings")
    public ResponseEntity<List<Map<String, Object>>> getMyListings(@RequestParam Long userId) {
        logger.debug("Fetching listings for user ID: {}", userId);
        List<Product> products = productService.getProductsByUserId(userId);
        List<Map<String, Object>> response = products.stream().map(product -> {
            Map<String, Object> productData = new LinkedHashMap<>();
            productData.put("id", product.getId());
            productData.put("name", product.getName());
            productData.put("description", product.getDescription());
            productData.put("category", product.getCategory());
            productData.put("price", product.getPrice());
            productData.put("imagePaths", product.getImagePaths());
            productData.put("sellerName", product.getSellerName());
            productData.put("sellerCollege", product.getSellerCollege());
            productData.put("userId", product.getUser().getId());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd hh:mm a");
            productData.put("postedDate", product.getPostedDate().format(formatter));
            return productData;
        }).collect(Collectors.toList());
        logger.debug("Found {} products for user ID: {}", response.size(), userId);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/search")
    public ResponseEntity<List<Map<String, Object>>> searchProducts(@RequestParam String query) {
        List<Product> products = productService.searchProducts(query);
        List<Map<String, Object>> response = products.stream().map(product -> {
            Map<String, Object> productData = new LinkedHashMap<>();
            productData.put("id", product.getId());
            productData.put("name", product.getName());
            productData.put("description", product.getDescription());
            productData.put("category", product.getCategory());
            productData.put("price", product.getPrice());
            productData.put("imagePaths", product.getImagePaths());
            productData.put("sellerName", product.getSellerName());
            productData.put("sellerCollege", product.getSellerCollege());
            productData.put("userId", product.getUser().getId());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd hh:mm a");
            productData.put("postedDate", product.getPostedDate().format(formatter));
            return productData;
        }).collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }

    // Add detailed logging to capture errors during product creation
    @PostMapping
    public ResponseEntity<?> createProduct(
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam String category,
            @RequestParam double price,
            @RequestParam String sellerName,
            @RequestParam String sellerCollege,
            @RequestParam Long userId,
            @RequestParam("images") MultipartFile[] images) {
        try {
            // Ensure the writable directory exists
            File uploadDirectory = new File("/tmp/uploads");
            if (!uploadDirectory.exists()) {
                if (!uploadDirectory.mkdirs()) {
                    return ResponseEntity.status(500).body("Failed to create upload directory");
                }
            }

            // Save images to the writable directory and generate public URLs
            StringBuilder imagePaths = new StringBuilder();
            String baseUrl = System.getenv("BASE_URL");
            if (baseUrl == null || baseUrl.isEmpty()) {
                baseUrl = "https://shopstateu-89a3d63aed8a.herokuapp.com"; // Fallback for Heroku
            }
            for (MultipartFile image : images) {
                if (image.isEmpty()) {
                    return ResponseEntity.badRequest().body("One or more images are empty");
                }
                String uniqueFilename = java.util.UUID.randomUUID() + "_" + image.getOriginalFilename();
                File file = new File(uploadDirectory, uniqueFilename);
                image.transferTo(file);
                String publicUrl = baseUrl + "/uploads/" + uniqueFilename;
                imagePaths.append(publicUrl).append(",");
            }

            // Create and save product
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setCategory(category);
            product.setPrice(price);
            product.setSellerName(sellerName);
            product.setSellerCollege(sellerCollege);
            product.setPostedDate(LocalDateTime.now()); // Keep LocalDateTime for database storage
            product.setImagePaths(imagePaths.toString());

            // Save product with user association
            productService.saveProduct(product, userId);

            return ResponseEntity.ok("Product created successfully");
        } catch (IOException e) {
            e.printStackTrace(); // Log stack trace for debugging
            return ResponseEntity.status(500).body("Error saving product images: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace(); // Log stack trace for debugging
            return ResponseEntity.status(500).body("Unexpected error: " + e.getMessage());
        }
    }

    // Add a new endpoint to serve uploaded files dynamically
    @GetMapping("/uploads/{filename}")
    public ResponseEntity<?> serveFile(@PathVariable String filename) {
        try {
            File file = new File("/tmp/uploads/" + filename);
            if (!file.exists()) {
                return ResponseEntity.status(404).body("File not found");
            }
            return ResponseEntity.ok().body(new org.springframework.core.io.FileSystemResource(file));
        } catch (Exception e) {
            logger.error("Error serving file: {}", e.getMessage());
            return ResponseEntity.status(500).body("An error occurred: " + e.getMessage());
        }
    }

    @GetMapping("/{productId}")
    public ResponseEntity<Map<String, Object>> getProductDetails(@PathVariable Long productId) {
        Product product = productService.getProductById(productId);
        if (product == null) {
            return ResponseEntity.status(404).body(Map.of("error", "Product not found"));
        }

        Map<String, Object> productData = new LinkedHashMap<>();
        productData.put("id", product.getId());
        productData.put("name", product.getName());
        productData.put("description", product.getDescription());
        productData.put("category", product.getCategory());
        productData.put("price", product.getPrice());
        productData.put("sellerName", product.getSellerName());
        productData.put("sellerCollege", product.getSellerCollege());
        productData.put("userId", product.getUser().getId());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd hh:mm a");
        productData.put("postedDate", product.getPostedDate().format(formatter));

        return ResponseEntity.ok(productData);
    }

    @GetMapping("/{productId}/images")
    public ResponseEntity<Map<String, List<String>>> getProductImages(@PathVariable Long productId) {
        Product product = productService.getProductById(productId);
        if (product == null) {
            return ResponseEntity.status(404).body(Map.of("error", List.of("Product not found")));
        }

        List<String> imagePaths = product.getImagePaths() != null ? List.of(product.getImagePaths().split(",")) : List.of();
        return ResponseEntity.ok(Map.of("images", imagePaths));
    }

    @PutMapping
    public ResponseEntity<?> updateProduct(
            @RequestParam Long id,
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam String category,
            @RequestParam double price,
            @RequestParam Long userId) {
        try {
            Product product = productService.getProductById(id);
            if (product == null) {
                return ResponseEntity.status(404).body("Product not found");
            }

            // Update product details
            product.setName(name);
            product.setDescription(description);
            product.setCategory(category);
            product.setPrice(price);
            productService.saveProduct(product, userId);

            return ResponseEntity.ok("Product updated successfully");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error updating product: " + e.getMessage());
        }
    }

    @DeleteMapping(value = "", params = "id")
    public ResponseEntity<?> deleteProduct(@RequestParam Long id) {
        try {
            Product product = productService.getProductById(id);
            if (product == null) {
                return ResponseEntity.status(404).body("Product not found");
            }

            productService.deleteProduct(id);
            return ResponseEntity.ok("Product deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("An error occurred while deleting the product: " + e.getMessage());
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