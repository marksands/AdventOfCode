import Foundation
import AdventOfCode

public final class Day1: Day {
    private let modules: [Double]
    
    public init(modules: [Double] = Input().inputCharactersByNewlines().compactMap(Double.init)) {
        self.modules = modules
        super.init()
    }
    
    public override func part1() -> String {
        let fuelValues = modules.reduce(into: 0.0, { seed, mass in
            let fuelRequiredForModule = floor(mass / 3.0) - 2
            seed += fuelRequiredForModule
        })
        return String(Int(fuelValues))
    }
    
    public override func part2() -> String {
        func fuelRequiredForInput(_ value: Double) -> Double {
            let fuelRequired = floor(value / 3.0) - 2
            if fuelRequired > 0 {
                return fuelRequired + fuelRequiredForInput(fuelRequired)
            } else {
                return 0
            }
        }
        
        let fuelValues = modules.reduce(into: 0.0, { seed, mass in
            seed += fuelRequiredForInput(mass)
        })
        return String(Int(fuelValues))
    }
}
