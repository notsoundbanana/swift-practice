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

    private let catalogService: CatalogService = MockCatalogService.shared

    func loadData() {
        do {
            products = try catalogService.obtainData()
        } catch {
            view?.showError(error)
        }
    }


}
