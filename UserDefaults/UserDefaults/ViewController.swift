//
//  ViewController.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 29.11.2022.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setup()
    }

    private func setupUI() {

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Notes"

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
        let noteVC = NoteViewController()
        show(noteVC, sender: self)
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
        25
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "text")
        cell.textLabel?.text = "Test"
        return cell
    }
}

