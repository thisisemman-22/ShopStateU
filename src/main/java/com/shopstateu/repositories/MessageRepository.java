package com.shopstateu.repositories;

import com.shopstateu.models.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {
    List<Message> findByRecipientName(String recipientName);
    List<Message> findBySenderName(String senderName);
}