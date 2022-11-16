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
    var dataSource = [Post]()


    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setup()

        Task{
            await obtainPosts()
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

    func obtainPosts() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode([Post].self, from: data)

            dataSource = response

            DispatchQueue.main.async {  // Обновляем таблицу в главном потоке
                self.tableView.reloadData()
            }
        } catch {
            print("Error: \(String(describing: error))")
        }
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


