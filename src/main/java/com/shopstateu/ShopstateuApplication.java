package com.shopstateu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.TimeZone;
import jakarta.annotation.PostConstruct;

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
}