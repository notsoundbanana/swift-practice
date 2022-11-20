//
//  ViewController.swift
//  Instagram-cw2
//
//  Created by Daniil Chemaev on 19.11.2022.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)

    private struct NamedImage {
            let title: String
            let url: URL
        }

    private var dataSource = [UsersList]()

    private var response: Response?

    let networkManager = NetworkManager()

    private struct UsersList {
        let name: String
    }


    private var usersList: [UsersList] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setup()

        Task{
            await networkManager.obtainPosts { [self] (result) in

                switch result {
                case .success(let response):
                    usersList = response.accounts.map { account in
                        UsersList(name: "\(account.user.name)")
                    }

                    self.response = response

                    self.dataSource = usersList

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(String(describing: error))")
                }

            }
        }
    }
    func setupUI() {

        navigationItem.title = "Users"

        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let profileVC = ProfileViewController()
        profileVC.accountInfo = response?.accounts[indexPath.row]
        show(profileVC, sender: self)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "text")
        tableView.reloadData()
    }



    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "text")

        let user = dataSource[indexPath.row]

        cell.textLabel?.text = user.name
        return cell
    }
}



