//
//  NewConversationViewController.swift
//  Messenger
//
//  Created by Муслим on 22.05.2024.
//

import UIKit

final class NewConversationViewController: UIViewController {
    
    var completion: ((String) -> Void)?
    
    private var items: [ChatUser] = []

    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = LayoutMetrics.module * 10
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTableView()
        fetchData()
    }

    // MARK: - Private methods
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(NewConversationTableViewCell.self, forCellReuseIdentifier: NewConversationTableViewCell.reuseId)
        
        setupTableViewLayout()
    }
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func fetchData() {
        DatabaseManager.shared.getAllUsers { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self.items = self.convert(from: users)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
        
    private func convert(from items: [[String: String]]) -> [ChatUser] {
        var result: [ChatUser] = []
        
        for item in items {
            guard let email = item["email"],
                  let username = item["username"]
            else {
                continue
            }
            
            result.append(
                ChatUser(
                    email: email,
                    username: username,
                    picture: UIImage(named: "person_placeholder")
                )
            )
        }
        return result
    }
}


    // MARK: - UITableViewDataSource

extension NewConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewConversationTableViewCell.reuseId,
            for: indexPath
        ) as? NewConversationTableViewCell else {
            fatalError("Can not dequeue NewConversationTableViewCell")
        }
        
        let user = items[indexPath.row]
        
        cell.configure(user: user)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension NewConversationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let item = items[indexPath.row]
        
        dismiss(animated: true) { [weak self] in
            self?.completion?(item.username)
        }
    }
}
