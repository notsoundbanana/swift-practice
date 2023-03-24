//
//  FightPresenter.swift
//  FightingSimulator2999
//
//  Created by Daniil Chemaev on 11.03.2023.
//

import UIKit
import Combine
import FightingServices

class FightPresenter {

    var fightService: FightService!
    weak var view: FightView?
    var showResult: (Result) -> Void = { _ in }
    var cancellables: Set<AnyCancellable> = []

    init(fightService: FightService, view: FightView) {
        self.fightService = fightService
        self.view = view

        // Subscriber for myHealth Publisher
        fightService.myHealth.receive(on: DispatchQueue.main).sink { [weak self] myHealth in
            guard let self else { return }

            if myHealth <= 0 {
                self.showResult(Result.lose)
                return
            } else {
                self.view?.setMyHealth(value: Float(myHealth))
            }
        }.store(in: &cancellables) // Is there any other solution?

        // Subscriber for myHealth Publisher
        fightService.enemyHealth.receive(on: DispatchQueue.main).sink { [weak self] enemyHealth in
            guard let self else { return }

            if enemyHealth <= 0 {
                self.showResult(Result.win)
                return
            } else {
                self.view?.setEnemyHealth(value: Float(enemyHealth))
            }
        }.store(in: &cancellables) // Is there any other solution?
    }
    

    func basicAttack() {
        fightService.basicAttack()
    }


    func magicAttack() {
        fightService.magicAttack()
    }
}
