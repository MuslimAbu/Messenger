//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Муслим on 15.05.2024.
//

import UIKit
import MessageKit
import InputBarAccessoryView

final class Message: MessageKit.MessageType {
    let sender: MessageKit.SenderType
    let messageId: String
    let sentDate: Date
    let kind: MessageKit.MessageKind
    
    init(sender: MessageKit.SenderType, messageId: String, sentDate: Date, kind: MessageKind) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
    }
}

final class Sender: MessageKit.SenderType {
    var senderId: String
    var displayName: String
    
    init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
}

final class ConversationViewController: MessagesViewController {
    
    private var messages: [Message] = []
    
    private var sender = Sender(senderId: "12345", displayName: "John John")
    
    private let otherUserEmail: String

    // MARK: - Init
    
    init(otherUserEmail: String) {
        self.otherUserEmail = otherUserEmail
        
        super.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages.append(
            Message(
            sender: sender,
            messageId: "Abcdefg",
            sentDate: Date(),
            kind: .text("Привет, что делаешь?")
            )
        )
        
        messages.append(
            Message(
            sender: sender,
            messageId: "Abcdefgded",
            sentDate: Date(),
            kind: .text("Привет, что делаешь?")
            )
        )
        
        messagesCollectionView.dataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        
        messageInputBar.delegate = self
        
        view.backgroundColor = .white
    }
}

extension ConversationViewController: MessagesDataSource {
    
    var currentSender: any MessageKit.SenderType {
        sender
    }
    
    func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessageKit.MessagesCollectionView
    ) -> any MessageKit.MessageType {
        messages[indexPath.item]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        messages.count
    }
}

// MARK: - InputBarAccessoryViewDelegate

extension ConversationViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = Message(
            sender: sender,
            messageId: "123",
            sentDate: Date(),
            kind: .text(text)
        )
        DatabaseManager.shared.createConversation(otherUserEmail: otherUserEmail, message: message) { success in
            if success {
                print("Успешно")
            } else {
                print("Неуспешно")
            }
        }
    }
}

// MARK: - MessagesDisplayDelegate

extension ConversationViewController: MessagesDisplayDelegate {}

// MARK: - MessagesLayoutDelegate

extension ConversationViewController: MessagesLayoutDelegate {}
