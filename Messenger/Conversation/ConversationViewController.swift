//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Муслим on 15.05.2024.
//

import UIKit
import MessageKit

final class MessageType: MessageKit.MessageType {
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

    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messagesCollectionView.dataSource = self
        
        view.backgroundColor = .white
    }
}

extension ConversationViewController: MessagesDataSource {
    
    var currentSender: any MessageKit.SenderType {
        Sender(senderId: "12345", displayName: "John Smith")
    }
    
    func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessageKit.MessagesCollectionView
    ) -> any MessageKit.MessageType {
        MessageType(
            sender: Sender(senderId: "123", displayName: "John Smith"),
            messageId: "Abcdefg",
            sentDate: Date(),
            kind: .text("Привет, что делаешь?")
        )
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        5
    }
}
