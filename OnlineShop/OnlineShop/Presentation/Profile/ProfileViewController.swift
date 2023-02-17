//
//  ProfileViewController.swift
//  OnlineShop
//
//  Created by Teacher on 11.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    var authorizationService: AuthorizationService
        = MockAuthorizationService.shared

    @IBAction private func signOut() {
        authorizationService.signOut()
    }
}
