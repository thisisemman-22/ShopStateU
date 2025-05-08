package com.shopstateu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.TimeZone;
import jakarta.annotation.PostConstruct;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.lang.NonNull;

@SpringBootApplication
public class ShopstateuApplication {

    public static void main(String[] args) {
        SpringApplication.run(ShopstateuApplication.class, args);
    }

    @PostConstruct
    public void init() {
        // Set default timezone to Asia/Manila
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Manila"));
    }

    @Bean
    public WebMvcConfigurer webMvcConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addResourceHandlers(@NonNull ResourceHandlerRegistry registry) {
                registry.addResourceHandler("/uploads/**")
                        .addResourceLocations("file:/tmp/uploads/");
            }
        };
    }
}