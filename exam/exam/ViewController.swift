
//
//  ViewController.swift
//  exam
//
//  Created by Daniil Chemaev on 14.01.2023.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)

    let networkManager = NetworkManager()  // Работа с сетью

    private struct TeamsList {
        let name: String
    }

    var teamsList: [Team] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()  // Настраиваем таблицу, ее dataSource итд
        setupUI()

        Task {
            if (teamsList.count == 0){
                await networkManager.obtainData { (result) in
                    self.teamsList = result
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let playersVC = PlayersViewController()
        playersVC.players = teamsList[indexPath.row].players
        playersVC.teams = teamsList  // TO-DO ПЕРЕДЕЛАТЬ
        playersVC.chosenTeam = indexPath.row
//        print(teamsList[indexPath.row])
        show(playersVC, sender: self)
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
        if (team.players.count < 5) {
            cell.detailTextLabel?.text = "Inactivate"
        }
        return cell
    }
}

