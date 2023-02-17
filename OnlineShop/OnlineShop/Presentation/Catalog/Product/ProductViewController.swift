//
//  ProductViewController.swift
//  OnlineShop
//
//  Created by Daniil Chemaev on 17.02.2023.
//

import UIKit

class ProductViewController: UIViewController {

    var presenter: ProductPresenter!
    var product: Product!

    private var nameLabel: UILabel = .init()
    private var discriptionLabel: UILabel = .init()
    private var priceLabel: UILabel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.loadData()
        insertData()
        setupUI()
    }

    private func insertData() {
        nameLabel.text = "Name: " + product.name
        discriptionLabel.text = "Description: " + product.description
        priceLabel.text = "Price: \(product.price)"
    }

    private func setupUI() {
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [nameLabel, discriptionLabel, priceLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
    }

    func setProduct(product: Product) {
        self.product = product
    }
}
