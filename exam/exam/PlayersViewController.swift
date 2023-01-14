//
//  PlayersTableViewController.swift
//  exam
//
//  Created by Daniil Chemaev on 14.01.2023.
//

import UIKit

class PlayersViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)

    var players: [Player] = []
    var chosenTeam: Int = 0
    var teams: [Team] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setup()

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
        let chooseTeamVC = ChooseTeamViewController()
        chooseTeamVC.teams = teams
        chooseTeamVC.chosenTeam = chosenTeam
        chooseTeamVC.chosenPlayer = indexPath.row
//        print("")
//        print(teams[chosenTeam])
//        print(teams[chosenTeam].players[indexPath.row])
        show(chooseTeamVC, sender: self)
//        navigationController?.present(chooseTeamVC, animated: true)
    }
}

extension PlayersViewController: UITableViewDataSource, UITableViewDelegate {

    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "text")
        tableView.reloadData()
    }



    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "text")

        let player = players[indexPath.row]

        cell.textLabel?.text = player.name
        return cell
    }
}



