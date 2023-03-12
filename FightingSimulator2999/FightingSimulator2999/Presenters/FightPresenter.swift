//
//  FightPresenter.swift
//  FightingSimulator2999
//
//  Created by Daniil Chemaev on 11.03.2023.
//

import UIKit

class FightPresenter {
    init(
        fightService: FightService,
        view: FightView
    ) {
        self.fightService = fightService
        self.view = view
    }

    private var fightService: FightService!
    private weak var view: FightView?


    @MainActor
    func basicAttack() {
        fightService.basicAttack()
        fightService.enemyHealth.receive(on: DispatchQueue.main).sink { enemyHealth in
            enemyHealth
        }
        let result = fightService.getHealths()
        view?.setMyHealth(value: Float(result.myHealth))
        view?.setEnemyHealth(value: Float(result.enemyHealth))
    }

    @MainActor
    func magicAttack() {
        fightService.magicAttack()
        let result = fightService.getHealths()
        view?.setMyHealth(value: Float(result.myHealth))
        view?.setEnemyHealth(value: Float(result.enemyHealth))
    }
}
