//
//  CatalogViewController.swift
//  OnlineShop
//
//  Created by Daniil Chemaev on 16.02.2023.
//

import UIKit

class CatalogViewController: UIViewController {

    var presenter: CatalogPresenter!
    var source: [Product]!

    private let catalogTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
        source = presenter.products

        setupUI()
        setConstraints()

        title = "Catalog"
    }

    private func setupUI() {
        navigationController?.tabBarItem = .init(title: "Catalog", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))

        view.addSubview(catalogTableView)
        catalogTableView.translatesAutoresizingMaskIntoConstraints = false

        setup()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate ([
            catalogTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            catalogTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            catalogTableView.topAnchor.constraint(equalTo: view.topAnchor),
            catalogTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "OOOPS", message: "Something went wrong: \(error)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertController, animated: true)
    }

}

extension CatalogViewController: UITableViewDataSource, UITableViewDelegate {

    func setup() {
        catalogTableView.dataSource = self
        catalogTableView.delegate = self
        catalogTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        source.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "text")
        cell.textLabel?.text = source[indexPath.row].name
        return cell
    }
}
