//
//  AuthorizationService.swift
//  OnlineShop
//
//  Created by Teacher on 11.02.2023.
//

import Foundation
import Combine

enum AuthorizationError: Error {
    case unauthorized
}

protocol AuthorizationService {
    var isAuthorized: AnyPublisher<Bool, Never> { get }

    func signIn(login: String, password: String) async throws
    func signOut()
}


class MockAuthorizationService: AuthorizationService {
    static let shared: MockAuthorizationService = .init()

    private var _isAuthorized: CurrentValueSubject<Bool, Never> = .init(false)

    var isAuthorized: AnyPublisher<Bool, Never> {
        _isAuthorized
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    func signIn(login: String, password: String) async throws {
        try? await Task.sleep(for: .seconds(1))
        if !(login == "admin" && password == "admin") {
            _isAuthorized.value = false
            throw AuthorizationError.unauthorized
        } else {
            _isAuthorized.value = true
        }
    }

    func signOut() {
        _isAuthorized.value = false
    }
}
