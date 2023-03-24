import Combine

public protocol FightService {
    var myHealth: AnyPublisher<Int, Never> { get }
    var enemyHealth: AnyPublisher<Int, Never> { get }
    /// Restores player and enemy health to 100
    func startFight()
    /// Deals 9 damage to enemy. Enemy attacks back and reduces `myHealth` by 10.
    func basicAttack()
    /// Deals 7-15 damage. Enemy attacks back and reduces `myHealth` by 10.
    func magicAttack()
}

