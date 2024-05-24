//
//  NewConversationTableViewCell.swift
//  Messenger
//
//  Created by Муслим on 23.05.2024.
//

import UIKit

final class NewConversationTableViewCell: UITableViewCell {

    static let reuseId = "NewConversationTableViewCell"

    // MARK: - UI Elements
    
    private let conversationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = LayoutMetrics.halfModule * 5
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
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
        setupTitleLabelLayout()
        setupSubtitleLabelLayout()
    }
    
    private func setupImageViewLayout(){
        contentView.addSubview(conversationImageView)
        
        conversationImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        conversationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutMetrics.doubleModule).isActive = true
        conversationImageView.widthAnchor.constraint(equalToConstant: LayoutMetrics.module * 5).isActive = true
        conversationImageView.heightAnchor.constraint(equalToConstant: LayoutMetrics.module * 5).isActive = true
    }
    
    private func setupTitleLabelLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: conversationImageView.topAnchor, constant: LayoutMetrics.halfModule).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: conversationImageView.trailingAnchor, constant: LayoutMetrics.module).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutMetrics.doubleModule).isActive = true
    }
    
    private func setupSubtitleLabelLayout() {
        contentView.addSubview(subtitleLabel)
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    func configure(user: ChatUser) {
        conversationImageView.image = user.picture
        titleLabel.text = user.email
        subtitleLabel.text = user.username
    }
}
