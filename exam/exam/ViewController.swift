//
//  ViewController.swift
//  exam
//
//  Created by Daniil Chemaev on 14.01.2023.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)

    private var dataSource = [TeamsList]()

    private var response: Response?

    let networkManager = NetworkManager()

    private struct TeamsList {
        let name: String
    }

    private var teamsList: [TeamsList] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupUI()

        Task{
            await networkManager.obtainPosts { [self] (result) in

                switch result {
                case .success(let response):
                    teamsList = response.teams.map { team in
                        TeamsList(name: "\(team.name)")
                    }

                    self.response = response

                    self.dataSource = teamsList

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(String(describing: error))")
                }

            }
        }
    }

    func setupUI(){

        navigationItem.title = "Супер-менеджер 3000"

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

        let user = dataSource[indexPath.row]

        cell.textLabel?.text = "123"
        return cell
    }
}

