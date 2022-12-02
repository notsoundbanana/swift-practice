//
//  ViewController.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 29.11.2022.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)

    private var allNotes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }

    private func setupUI() {

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Notes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightNavigationBarButtonTapped(sender:)))

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
        let noteVC = NoteViewController()
        noteVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(noteVC, animated: true)
    }

    @objc func rightNavigationBarButtonTapped(sender: UIBarButtonItem) {
        let noteVC = NoteViewController()
        noteVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(noteVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func loadData() {
        if let res = UserDefaults.standard.object(forKey: "note") as? Data {
            let decoder = JSONDecoder()

            guard let notes = try? decoder.decode([Note].self, from: res) else { return }
            allNotes = notes
        }
    }

    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "text")
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "text")
        cell.textLabel?.text = allNotes[indexPath.row].title
        cell.detailTextLabel?.text = allNotes[indexPath.row].creationDate
        return cell
    }
}