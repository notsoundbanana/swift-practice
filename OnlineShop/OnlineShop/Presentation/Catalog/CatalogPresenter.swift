//
//  CatalogPresenter.swift
//  OnlineShop
//
//  Created by Daniil Chemaev on 16.02.2023.
//

import UIKit

class CatalogPresenter {

    weak var view: CatalogViewController?
    var products: [Product]?
    var navigationController: UINavigationController?

    private let catalogService: CatalogService = MockCatalogService.shared

    func loadData() {
        do {
            products = try catalogService.obtainData()
            view?.products = products
        } catch {
            view?.showError(error)
        }
    }
}
