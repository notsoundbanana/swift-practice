//
//  MockFightService.swift
//  FightingSimulator2999Tests
//
//  Created by Teacher on 11.03.2023.
//

import Foundation
import Combine
import FightingServices

@testable import FightingSimulator2999

class MockFightService: FightService {

    var _myHealth: CurrentValueSubject<Int, Never> = .init(100)
    var _enemyHealth: CurrentValueSubject<Int, Never> = .init(100)

    var myHealth: AnyPublisher<Int, Never> { _myHealth.eraseToAnyPublisher() }
    var enemyHealth: AnyPublisher<Int, Never> { _enemyHealth.eraseToAnyPublisher() }

    var startFightCalled: Bool = false
    var basicAttackCalled: Bool = false
    var magicAttackCalled: Bool = false

    func startFight() {
        startFightCalled = true
    }

    func basicAttack() {
        basicAttackCalled = true
    }

    func magicAttack() {
        magicAttackCalled = true
    }

    func getHealths() -> (enemyHealth: Int, myHealth: Int) {
        return (1, 1)
    }
}
