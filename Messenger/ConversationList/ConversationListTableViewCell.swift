//
//  ConversationListTableViewCell.swift
//  Messenger
//
//  Created by Муслим on 15.05.2024.
//

import UIKit

final class ConversationListTableViewCell: UITableViewCell {
    
    static let reuseId = "ConversationListTableViewCell"

    // MARK: - UI Elements
    
    private let conversationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = LayoutMetrics.halfModule * 5
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupLayout(){
        setupImageViewLayout()
    }
    
    private func setupImageViewLayout(){
        contentView.addSubview(conversationImageView)
        
        conversationImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        conversationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutMetrics.doubleModule).isActive = true
        conversationImageView.widthAnchor.constraint(equalToConstant: LayoutMetrics.module * 5).isActive = true
        conversationImageView.heightAnchor.constraint(equalToConstant: LayoutMetrics.module * 5).isActive = true
    }
    
    func configure() {}
    
}
