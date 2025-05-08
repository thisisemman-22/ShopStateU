package com.shopstateu.controllers;

import com.shopstateu.models.Message;
import com.shopstateu.services.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/messages")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @GetMapping("/inbox")
    public ResponseEntity<List<Message>> getInboxMessages(@RequestParam String recipientName) {
        List<Message> messages = messageService.getInboxMessages(recipientName);
        return ResponseEntity.ok(messages);
    }

    @GetMapping("/sent")
    public ResponseEntity<List<Message>> getSentMessages(@RequestParam String senderName) {
        List<Message> messages = messageService.getSentMessages(senderName);
        return ResponseEntity.ok(messages);
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
}