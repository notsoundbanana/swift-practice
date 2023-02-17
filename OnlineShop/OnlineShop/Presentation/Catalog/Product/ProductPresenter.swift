//
//  ProductPresenter.swift
//  OnlineShop
//
//  Created by Daniil Chemaev on 17.02.2023.
//

import UIKit

class ProductPresenter {

    weak var view: ProductViewController?
    var product: Product?
    var navigationController: UINavigationController?

    private let catalogService: CatalogService = MockCatalogService.shared

    func loadData() {
        view?.product = product
    }
}
