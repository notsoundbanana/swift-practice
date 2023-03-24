//
//  FightingSimulator2999Tests.swift
//  FightingSimulator2999Tests
//
//  Created by Teacher on 11.03.2023.
//

import XCTest
import FightingServices
@testable import FightingSimulator2999

final class FightingSimulator2999Tests: XCTestCase {

    var fightService: FightService!
    var fightView: MockFightView!
    var presenter: FightPresenter!

    @MainActor
    override func setUp() {
        fightService = MockFightService()
        fightView = MockFightView()
        presenter = FightPresenter(fightService: fightService, view: fightView)
    }


    func testLogInIsCalled() async {
        await presenter.basicAttack()

        let result = await fightView.myHealthChanged
        XCTAssertTrue(result)
    }
}
