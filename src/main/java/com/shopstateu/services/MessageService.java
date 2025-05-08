package com.shopstateu.services;

import com.shopstateu.models.Message;
import com.shopstateu.repositories.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class MessageService {

    @Autowired
    private MessageRepository messageRepository;

    public List<Message> getInboxMessages(String recipientName) {
        return messageRepository.findByRecipientName(recipientName);
    }

    public List<Message> getSentMessages(String senderName) {
        return messageRepository.findBySenderName(senderName);
    }

    public Message sendMessage(String senderName, String recipientName, String messageContent) {
        Message message = new Message();
        message.setSenderName(senderName);
        message.setRecipientName(recipientName);
        message.setMessageContent(messageContent);
        message.setTimestamp(LocalDateTime.now()); // Keep LocalDateTime for database storage
        return messageRepository.save(message);
    }
}