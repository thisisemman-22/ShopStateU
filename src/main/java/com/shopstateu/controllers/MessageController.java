package com.shopstateu.controllers;

import com.shopstateu.models.Message;
import com.shopstateu.services.MessageService;
import com.shopstateu.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@RestController
@RequestMapping("/api/messages")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private UserService userService;

    @GetMapping("/inbox")
    public ResponseEntity<List<Map<String, Object>>> getInboxMessages(@RequestParam String recipientName) {
        List<Message> messages = messageService.getInboxMessages(recipientName);
        List<Map<String, Object>> response = messages.stream().map(message -> {
            Map<String, Object> messageData = new HashMap<>();
            messageData.put("id", message.getId());
            messageData.put("senderName", message.getSenderName());
            messageData.put("messageContent", message.getMessageContent());
            messageData.put("timestamp", formatTimestamp(message.getTimestamp())); // Format timestamp
            messageData.put("senderProfilePicture", userService.getProfilePictureByName(message.getSenderName())); // Fetch sender's profile picture
            return messageData;
        }).collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/sent")
    public ResponseEntity<List<Map<String, Object>>> getSentMessages(@RequestParam String senderName) {
        List<Message> messages = messageService.getSentMessages(senderName);
        List<Map<String, Object>> response = messages.stream().map(message -> {
            Map<String, Object> messageData = new HashMap<>();
            messageData.put("id", message.getId());
            messageData.put("recipientName", message.getRecipientName());
            messageData.put("messageContent", message.getMessageContent());
            messageData.put("timestamp", formatTimestamp(message.getTimestamp())); // Format timestamp
            messageData.put("recipientProfilePicture", userService.getProfilePictureByName(message.getRecipientName())); // Fetch recipient's profile picture
            return messageData;
        }).collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }

    @PostMapping
    public ResponseEntity<?> sendMessage(@RequestParam String senderName,
                                         @RequestParam String recipientName,
                                         @RequestParam String messageContent) {
        if (recipientName == null || messageContent == null || messageContent.isEmpty()) {
            return ResponseEntity.badRequest().body("All fields (recipientName, messageContent) are required.");
        }

        try {
            Message message = messageService.sendMessage(senderName, recipientName, messageContent);
            return ResponseEntity.ok(message);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("An error occurred while sending the message: " + e.getMessage());
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

    private String formatTimestamp(LocalDateTime timestamp) {
        try {
            DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("MM/dd hh:mm a");
            return timestamp.format(outputFormatter);
        } catch (Exception e) {
            return timestamp.toString(); // Return original if formatting fails
        }
    }
}