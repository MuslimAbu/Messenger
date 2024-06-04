//
//  ConversationsViewController.swift
//  Messenger
//
//  Created by Муслим on 04.05.2024.
//

import UIKit

final class ConversationListViewController: UIViewController {
    
    private var conversations: [Conversation] = []
    
    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = LayoutMetrics.module * 10
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        title = "Chats"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: #selector(newChatButtonTapped)
        )
        
        setupSearchController()
        setupTableView()
    }
    
    // MARK: - Private methods
    
    private func setupSearchController() {
        let searchController = UISearchController()
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ConversationListTableViewCell.self, forCellReuseIdentifier: ConversationListTableViewCell.reuseId)
        
        setupTableViewLayout()
    }
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc
    private func newChatButtonTapped() {
        let vc = NewConversationViewController()
        vc.completion = { [weak self] username, email in
            self?.showConversationViewController(username: username, email: email)
        }
        present(vc, animated: true)
    }
    
    private func showConversationViewController(username: String, email: String) {
        let viewcontroller = ConversationViewController(otherUserEmail: email)
        viewcontroller.title = username
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ConversationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ConversationListTableViewCell.reuseId,
            for: indexPath
        ) as? ConversationListTableViewCell else {
            fatalError("Can not dequeue ConversationListTableViewCell")
        }
        
        cell.configure()
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ConversationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showConversationViewController(username: "", email: "")
    }
}
