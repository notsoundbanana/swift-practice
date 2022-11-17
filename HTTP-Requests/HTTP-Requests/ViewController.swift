//
//  ViewController.swift
//  HTTP-Requests
//
//  Created by Daniil Chemaev on 16.11.2022.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    var dataSource = [Post]()

    let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setup()

        Task{
            await networkManager.obtainPosts { (result) in

                switch result {
                case .success(let posts):
                    self.dataSource = posts

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
        view.backgroundColor = .red

        navigationItem.title = "Title"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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

        let post = dataSource[indexPath.row]

        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }
}


