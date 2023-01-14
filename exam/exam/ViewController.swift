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

    private var teamsList: [Team] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupUI()

        Task {
            await networkManager.obtainData { (result) in
            self.teamsList = result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
        teamsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "text")

        let team = teamsList[indexPath.row]

        cell.textLabel?.text = team.name
        return cell
    }
}

