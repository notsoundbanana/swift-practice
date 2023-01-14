//
//  ChooseGroupViewController.swift
//  exam
//
//  Created by Daniil Chemaev on 14.01.2023.
//

import UIKit

class ChooseTeamViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)

    var teams: [Team] = []
    var chosenTeam: Int = 0
    var chosenPlayer: Int = 0


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

        let curPlayer = teams[chosenTeam].players[chosenPlayer]  // Сохраняем текущего игрока
//        print("")

//        print(curPlayer)
        teams[indexPath.row].players.append(curPlayer) // Переносим
        teams[chosenTeam].players.remove(at: chosenPlayer) // Удаляем

//        print(teams[chosenTeam])
//        print("")
//        print(teams[indexPath.row])
//        print(teams[chosenTeam].players)

        let vc = ViewController()  // TODO Добавить кордату
        vc.teamsList = teams

        show(vc, sender: self)
        
//        dismiss(animated: true)
        

    }
}

extension ChooseTeamViewController: UITableViewDataSource, UITableViewDelegate {

    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "text")
        tableView.reloadData()
    }



    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teams.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "text")

        let team = teams[indexPath.row]

        cell.textLabel?.text = team.name
        return cell
    }
}




