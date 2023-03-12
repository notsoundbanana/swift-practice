//
//  ResultViewController.swift
//  FightingSimulator2999
//
//  Created by Teacher on 11.03.2023.
//

import UIKit

enum Result {
    case win
    case lose
}

class ResultViewController: UIViewController {

    var result: Result = .lose

    @IBOutlet
    private var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        switch result {
        case .win:
            resultLabel.text = "You win!"
        case .lose:
            resultLabel.text = "You lose!"
        }
    }

    @IBAction
    private func restartTap() {
        FightCoordinator.shared.restart()
    }
}
