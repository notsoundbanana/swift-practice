//
//  ViewController.swift
//  HTTP-Requests
//
//  Created by Daniil Chemaev on 16.11.2022.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    let session = URLSession.shared
    var posts: [Post] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setup()
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "text")
    }


    func obtainPosts() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode([Post].self, from: data)
            print("posts: \(response)")


        } catch {
            print("Error: \(String(describing: error))")
        }
    }
}


