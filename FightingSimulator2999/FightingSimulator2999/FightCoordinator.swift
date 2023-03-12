//
//  FightCoordinator.swift
//  FightingSimulator2999
//
//  Created by Daniil Chemaev on 11.03.2023.
//

import UIKit

@MainActor
public class FightCoordinator {
    weak var window: UIWindow?
    static let shared: FightCoordinator = .init()

    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    private weak var navigationController: UINavigationController?
    var service: FightService!


    func start() -> UIViewController {
        let controller: FightViewController = storyboard.instantiateViewController(identifier: "FightViewController")
        let presenter = FightPresenter(fightService: FightServiceImplementation.shared, view: controller)

        controller.presenter = presenter

        let navigationController = UINavigationController(rootViewController: controller)
        self.navigationController = navigationController

        return navigationController
    }

    func showResultViewController(result: Result) {
        let controller: ResultViewController = storyboard.instantiateViewController(identifier: "ResultViewController")
        controller.result = result
        navigationController?.pushViewController(controller, animated: true)
    }

    func restart() {
        
    }
}
