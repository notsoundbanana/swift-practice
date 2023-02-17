//
//  CatalogCoordinator.swift
//  OnlineShop
//
//  Created by Daniil Chemaev on 17.02.2023.
//

import UIKit

class CatalogCoordinator {
    static let shared = CatalogCoordinator()
    var navigationController: UINavigationController?

    func start() -> UIViewController{
        let catalogViewController = CatalogViewController()
        let catalogPresenter = CatalogPresenter()
        catalogViewController.presenter = catalogPresenter
        catalogPresenter.view = catalogViewController

        navigationController = UINavigationController(rootViewController: catalogViewController)
        return navigationController!
    }
}
