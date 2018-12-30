import Foundation
import AdventOfCode

public final class Day7: Day {
    enum Gate {
        case not
        case and
        case or
        case lshift
        case rshift
        case set
    }
    
    struct Circuit {
        let a: String
        let b: String
        let output: String
        let gate: Gate
    }
    
    let circuits: [Circuit]
    
    public override init() {
        let regex = Regex(pattern: "(NOT|[a-z]*|\\d+)\\s?(AND|OR|LSHIFT|RSHIFT)?\\s?([a-z]*|\\d+) -> ([a-z]*)")

        let input = Input().trimmedInputCharactersByNewlines()
        circuits = input.compactMap { line -> Circuit? in
            if let matches = regex.matches(in: line)?.matches.filter({ !$0.isEmpty }) {
                if matches[1] == "NOT" {
                    return Circuit(a: matches[2], b: "", output: matches[3], gate: .not)
                } else if matches[2] == "AND" {
                    return Circuit(a: matches[1], b: matches[3], output: matches[4], gate: .and)
                } else if matches[2] == "OR" {
                    return Circuit(a: matches[1], b: matches[3], output: matches[4], gate: .or)
                } else if matches[2] == "LSHIFT" {
                    return Circuit(a: matches[1], b: matches[3], output: matches[4], gate: .lshift)
                } else if matches[2] == "RSHIFT" {
                    return Circuit(a: matches[1], b: matches[3], output: matches[4], gate: .rshift)
                } else {
                    return Circuit(a: matches[1], b: "", output: matches[2], gate: .set)
                }
            }
            return nil
        }
        
        super.init()
    }
    
    public override func part1() -> String {
        return String(runCircuit()["a"]!)
    }

    public override func part2() -> String {
        return String(runCircuit(wireB: runCircuit()["a"]!)["a"]!)
    }
    
    private func runCircuit(wireB: Int? = nil) -> [String: Int] {
        var wires: [String: Int] = [:]
        wires["b"] = wireB
        circuits.forEach { circuit in
            setWire(circuit, wires: &wires)
        }
        return wires
    }
    
    private func findWireValue(_ value: String, from wires: inout [String: Int]) -> Int {
        if let result = Int(value) ?? wires[value] {
            return result
        }
        let circuitOutputtingValue = circuits.first(where: { $0.output == value })!
        setWire(circuitOutputtingValue, wires: &wires)
        return findWireValue(value, from: &wires)
    }
    
    private func setWire(_ circuit: Circuit, wires: inout [String: Int]) {
        switch circuit.gate {
        case .set: wires[circuit.output] = findWireValue(circuit.a, from: &wires)
        case .lshift: wires[circuit.output] = findWireValue(circuit.a, from: &wires) << findWireValue(circuit.b, from: &wires)
        case .rshift: wires[circuit.output] = findWireValue(circuit.a, from: &wires) >> findWireValue(circuit.b, from: &wires)
        case .not: wires[circuit.output] = ~findWireValue(circuit.a, from: &wires)
        case .and: wires[circuit.output] = findWireValue(circuit.a, from: &wires) & findWireValue(circuit.b, from: &wires)
        case .or: wires[circuit.output] = findWireValue(circuit.a, from: &wires) | findWireValue(circuit.b, from: &wires)
        }
    }
}
