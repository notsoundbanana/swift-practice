//
//  ViewController.swift
//  FightingSimulator2999
//
//  Created by Teacher on 11.03.2023.
//

import UIKit


protocol FightView: AnyObject {
    func setMyHealth(value: Float)
    func setEnemyHealth(value: Float)
}


class FightViewController: UIViewController, FightView {
    @IBOutlet private var myHealthView: UIProgressView!
    @IBOutlet private var enemyHealthView: UIProgressView!

    var presenter: FightPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        myHealthView.progress = 1
        enemyHealthView.progress = 1
    }

    @IBAction
    private func basicAttackTap() {
        presenter.basicAttack()
    }

    @IBAction
    private func magicAttackTap() {
        presenter.magicAttack()
    }

    func setMyHealth(value: Float) {
        myHealthView.progress = value / 100
        if (value / 100 == 0) {
            FightCoordinator.shared.showResultViewController(result: .lose)
        }
    }

    func setEnemyHealth(value: Float) {
        enemyHealthView.progress = value / 100
        if (value / 100 == 0) {
            FightCoordinator.shared.showResultViewController(result: .win)
        }
    }
}

