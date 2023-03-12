//
//  MockFightView.swift
//  FightingSimulator2999Tests
//
//  Created by Daniil Chemaev on 11.03.2023.
//

import UIKit
@testable import FightingSimulator2999


class MockFightView: FightView {
    var myHealthChanged: Bool = false
    var enemyHealthChanged: Bool = false

    func setMyHealth(value: Float) {
        myHealthChanged = true
    }

    func setEnemyHealth(value: Float) {
        enemyHealthChanged = true
    }

}

