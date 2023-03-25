//
//  FightCoordinator.swift
//  FightingSimulator2999
//
//  Created by Daniil Chemaev on 11.03.2023.
//

import UIKit
import FightingServices
import FightingServiceImplementation


public class FightCoordinator {
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    weak var window: UIWindow?

    var services: ServiceLocator!
    static let shared: FightCoordinator = .init()

    lazy var fightService: FightService = services.resolve()

    func start() {
        fightService.startFight() 
        showFightViewController()
    }

    func showFightViewController() {
        let controller: FightViewController = storyboard.instantiateViewController(identifier: "FightViewController")
        let presenter = FightPresenter(fightService: fightService, view: controller)
        controller.presenter = presenter
        presenter.showResult = showResultViewController
        window?.rootViewController = controller
    }

    func showResultViewController(result: Result) {
        let controller: ResultViewController = storyboard.instantiateViewController(identifier: "ResultViewController")
        controller.result = result
        window?.rootViewController = controller
    }
}
