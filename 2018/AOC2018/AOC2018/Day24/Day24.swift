import Foundation

public final class Day24: Day {
    enum Attribute: String {
        case radiation = "radiation"
        case bludgeoning = "bludgeoning"
        case slashing = "slashing"
        case cold = "cold"
        case fire = "fire"
    }
    
    class Unit: Hashable {
        var quantity: Int
        var hp: Int
        var attack: Int
        let attackType: Attribute
        let initiative: Int
        let weaknesses: [Attribute]
        let immunities: [Attribute]
        
        init(quantity: Int, hp: Int, attack: Int, attackType: Attribute, initiative: Int, weaknesses: [Attribute], immunities: [Attribute]) {
            self.quantity = quantity
            self.hp = hp
            self.attack = attack
            self.attackType = attackType
            self.initiative = initiative
            self.weaknesses = weaknesses
            self.immunities = immunities
        }
        
        var effectivePower: Int {
            return quantity * attack
        }
        
        func damageDealt(by unit: Unit) -> Int {
            guard !immunities.contains(unit.attackType) else { return 0 }
            let multiplier = weaknesses.contains(unit.attackType) ? 2 : 1
            return unit.effectivePower * multiplier
        }
        
        func unitsDestroyedIfAttacked(by unit: Unit) -> Int {
            return max(0, Int(damageDealt(by: unit)/hp))
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(initiative)
        }
        
        static func == (lhs: Day24.Unit, rhs: Day24.Unit) -> Bool {
            return lhs.initiative == rhs.initiative
        }
    }

    private var immuneSystem: [Unit] = []
    private var infection: [Unit] = []
    
    override public init() {
        super.init()
        reset()
    }
    
    private func reset() {
        let attackingRegexPattern = "^(\\d+) units each with (\\d+) hit points with an attack that does (\\d+) (\\w+) damage at initiative (\\d+)$"
        let withAttributesRegexPattern = "^(\\d+) units each with (\\d+) hit points (\\(.+\\))* with an attack that does (\\d+) (\\w+) damage at initiative (\\d+)$"
        let attackRegex = Regex(pattern: attackingRegexPattern)
        let attributeRegex = Regex(pattern: withAttributesRegexPattern)
        
        let armies = Input().trimmedRawInput().components(separatedBy: "\n\n")
        let immuneSystemLines = armies[0].components(separatedBy: .newlines).dropFirst()
        let infectionLines = armies[1].components(separatedBy: .newlines).dropFirst()
        
        let makeUnits = { (line: String) -> Unit? in
            if let matches = attackRegex.matches(in: line) {
                return Unit(quantity: Int(matches[1])!, hp: Int(matches[2])!, attack: Int(matches[3])!, attackType: Attribute(rawValue: matches[4])!, initiative: Int(matches[5])!, weaknesses: [], immunities: [])
            } else if let matches = attributeRegex.matches(in: line) {
                let attributeSequence = matches[3]
                
                var weak: [Attribute] = []
                var immune: [Attribute] = []
                
                attributeSequence.components(separatedBy: ";").forEach { sequence in
                    if sequence.contains("immune") {
                        immune = sequence
                            .components(separatedBy: CharacterSet.punctuationCharacters.union(.whitespaces))
                            .compactMap(Attribute.init)
                    } else if sequence.contains("weak") {
                        weak = sequence
                            .components(separatedBy: CharacterSet.punctuationCharacters.union(.whitespaces))
                            .compactMap(Attribute.init)
                    }
                }
                
                return Unit(quantity: Int(matches[1])!, hp: Int(matches[2])!, attack: Int(matches[4])!, attackType: Attribute(rawValue: matches[5])!, initiative: Int(matches[6])!, weaknesses: weak, immunities: immune)
            } else {
                return nil
            }
        }
        
        immuneSystem = immuneSystemLines.compactMap(makeUnits)
        infection = infectionLines.compactMap(makeUnits)
    }
    
    private func fight(boost: Int = 0) {
        for unit in immuneSystem {
            unit.attack += boost
        }
        
        while infection.reduce(false, { $0 || $1.quantity > 0 }) && immuneSystem.reduce(false, { $0 || $1.quantity > 0 }) {
            var attackers: [Unit: Unit] = [:]
            var chosen = Set<Unit>()
            infection
                .sorted(by: { ($0.effectivePower, $0.initiative) > ($1.effectivePower, $0.initiative) })
                .forEach { infectionUnit in
                    if let defender = bestTarget(for: infectionUnit, from: immuneSystem.filter({ !chosen.contains($0) })) {
                        chosen.insert(defender)
                        attackers[infectionUnit] = defender
                    }
            }
            immuneSystem
                .sorted(by: { ($0.effectivePower, $0.initiative) > ($1.effectivePower, $0.initiative) })
                .forEach { immuneSystemUnit in
                    if let defender = bestTarget(for: immuneSystemUnit, from: infection.filter({ !chosen.contains($0) })) {
                        chosen.insert(defender)
                        attackers[immuneSystemUnit] = defender
                    }
            }

            var attacks = 0
            attackers.sorted(by: { $0.key.initiative > $1.key.initiative }).forEach { attacker, defender in
                battle(attacker, defender)
                attacks += 1
                infection.removeAll(where: { $0.quantity <= 0 })
                immuneSystem.removeAll(where: { $0.quantity <= 0 })
            }
            
            if attacks == 0 {
                immuneSystem.removeAll()
            }
        }
    }
    
    private func battle(_ attacker: Unit, _ defender: Unit) {
        let destroyed = defender.unitsDestroyedIfAttacked(by: attacker)
        defender.quantity -= destroyed
    }
    
    private func bestTarget(for unit: Unit, from enemies: [Unit]) -> Unit? {
        let sortDescriptor: (Unit, Unit) -> Bool = {
            ($0.damageDealt(by: unit), $0.effectivePower, $0.initiative) > ($1.damageDealt(by: unit), $1.effectivePower, $1.initiative)
        }

        return enemies.sorted(by: sortDescriptor).filter { $0.damageDealt(by: unit) > 0 }.first
    }
    
    public override func part1() -> String {
        fight()
        return String(infection.map { $0.quantity }.sum())
    }
    
    public override func part2() -> String {
        var boost = 1
        var result = 0
        repeat {
            fight(boost: boost)
            result = immuneSystem.map { $0.quantity }.sum()
            reset()
            boost += 1
        } while (result == 0)
        
        return String(result)
    }
}
