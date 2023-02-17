//
//  AppCoordinator.swift
//  OnlineShop
//
//  Created by Teacher on 11.02.2023.
//

import UIKit
import Combine

@MainActor
class AppCoordinator {
    weak var window: UIWindow?
    static let shared: AppCoordinator = .init()

    var authorizationService: AuthorizationService
        = MockAuthorizationService.shared

    var cancellables: Set<AnyCancellable> = []

    func start() {
        authorizationService.isAuthorized
            .receive(on: DispatchQueue.main)
            .sink { [weak self] authorized in
                guard let self else { return }

                if authorized {
                    self.showAppContent()
                } else {
                    self.showAuthorization()
                }
            }
            .store(in: &cancellables)
    }

    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func showAuthorization() {
        let controller: LoginViewController = storyboard.instantiateViewController(identifier: "LoginViewController")
        let presenter = LoginPresenter()
        controller.presenter = presenter
        presenter.view = controller
        window?.rootViewController = controller
    }

    func showAppContent() {
        let tabBarCoordinator = MainTabBarCoordinator()
        window?.rootViewController = tabBarCoordinator.start()
    }
}
