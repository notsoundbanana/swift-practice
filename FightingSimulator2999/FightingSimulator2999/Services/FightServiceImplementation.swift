//
//  FightServiceImpl.swift
//  FightingSimulator2999
//
//  Created by Daniil Chemaev on 11.03.2023.
//

import Foundation
import Combine

class FightServiceImplementation: FightService {

    static let shared: FightServiceImplementation = .init()

    var _myHealth: CurrentValueSubject<Int, Never> = .init(100)
    var _enemyHealth: CurrentValueSubject<Int, Never> = .init(100)

    var myHealth: AnyPublisher<Int, Never> {
        _myHealth.eraseToAnyPublisher()
    }

    var enemyHealth: AnyPublisher<Int, Never> {
        _enemyHealth.eraseToAnyPublisher()
    }

    func startFight() {
        print(_myHealth.value)
        print(_enemyHealth.value)
    }

    func basicAttack() {
        _enemyHealth.value -= 9
        _myHealth.value -= 10
    }

    func magicAttack() {
        _enemyHealth.value -= Int.random(in: 7...15)
        _myHealth.value -= 10
    }

    func getHealths() -> (enemyHealth: Int, myHealth: Int) {
        return (enemyHealth: _enemyHealth.value, myHealth: _myHealth.value)
    }
}
