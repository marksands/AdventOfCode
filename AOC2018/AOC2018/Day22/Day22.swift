import Foundation

public final class Day22: Day {
    enum RegionType {
        case rocky
        case narrow
        case wet
        
        var risk: Int {
            switch self {
            case .rocky: return 0
            case .wet: return 1
            case .narrow: return 2
            }
        }
    }
    
    enum Tool: Hashable {
        case torch
        case climbingGear
        case neither
    }
    
    struct Spelunk: Hashable {
        let position: Position
        let tool: Tool
        let costDelta: Int
    }
    
    private let depth = 3_879
    private let target = Position(x: 8, y: 713)
    
    private var erosionLevels: [Position: Int] = [:]
    private var regionTypes: [Position: RegionType] = [:]
    
    public override func part1() -> String {
        populateRegion()
        return String(regionTypes.values.map({ $0.risk }).sum())
    }
    
    public override func part2() -> String {
        populateRegion(padding: 2000)
        let first = Spelunk(position: Position.zero, tool: .torch, costDelta: 0)
        let result = path(from: first, to: target).map { $0.costDelta }.sum()
        return String(result)
    }
    
    private func populateRegion(padding: Int = 0) {
        (0...(target.y + padding)).forEach { y in
            (0...(target.x + padding)).forEach { x in
                let position = Position(x: x, y: y)
                regionTypes[position] = regionType(for: position)
            }
        }
    }
    
    private func path(from source: Spelunk, to target: Position) -> [Spelunk] {
        var queue = PriorityQueue<[Spelunk]>(sort: {
            $0.map { $0.costDelta }.sum() < $1.map { $0.costDelta }.sum()
        })
        queue.enqueue([source])
        
        var visitedTiles = Set<Spelunk>()
        
        while queue.count > 0 {
            let path = queue.dequeue()!
            
            if path.last?.position == target && path.last?.tool == .torch {
                return path
            } else if let current = path.last {
                for spelunk in neighbors(for: current) {
                    if !visitedTiles.contains(spelunk) {
                        visitedTiles.insert(spelunk)
                        queue.enqueue(path + [spelunk])
                    }
                }
            }
        }
        
        return []
    }
    
    private func neighbors(for spelunky: Spelunk) -> [Spelunk] {
        let makeSpelunky = { [unowned self] position -> [Spelunk]? in
            return self.regionTypes[position].map { [unowned self] type in
                return self.validTools(forNewPosition: position, currentPosition: spelunky.position).map { tool in
                    if tool == spelunky.tool {
                        return Spelunk(position: position, tool: tool, costDelta: 1)
                    } else {
                        return Spelunk(position: spelunky.position, tool: tool, costDelta: 7)
                    }
                }
            }
        }
        
        let adjacent = [spelunky.position.north(), spelunky.position.west(), spelunky.position.east(), spelunky.position.south()]
        return adjacent.compactMap { makeSpelunky($0) }.flatMap { $0 }.sorted { $0.costDelta < $1.costDelta }
    }
    
    private func validTools(forNewPosition position: Position, currentPosition current: Position) -> [Tool] {
        guard let region = regionTypes[position] else { return [] }
        
        if position == target {
            return [.torch]
        }
        
        let existingRegion = regionTypes[current]!
        
        switch (region, existingRegion) {
        case (.rocky, .rocky): return [.climbingGear, .torch]
        case (.wet, .wet): return [.climbingGear, .neither]
        case (.narrow, .narrow): return [.torch, .neither]

        case (.rocky, .wet): fallthrough
        case (.wet, .rocky):  return [.climbingGear]

        case (.rocky, .narrow): fallthrough
        case (.narrow, .rocky):  return [.torch]

        case (.wet, .narrow): fallthrough
        case (.narrow, .wet): return [.neither]
        }
    }
    
    private func geologicalIndex(for position: Position) -> Int {
        guard position != .zero && position != target else { return 0 }
        
        if position.y == 0 {
            return position.x * 16_807
        } else if position.x == 0 {
            return position.y * 48_271
        } else {
            return erosionLevel(for: position.west()) * erosionLevel(for: position.north())
        }
    }
    
    private func erosionLevel(for position: Position) -> Int {
        if erosionLevels[position] == nil {
            erosionLevels[position] = (geologicalIndex(for: position) + depth) % 20183
        }
        return erosionLevels[position]!
    }
    
    private func regionType(for position: Position) -> RegionType {
        let level = erosionLevel(for: position)
        
        if level % 3 == 0 {
            return .rocky
        } else if level % 3 == 1 {
            return .wet
        } else if level % 3 == 2 {
            return .narrow
        } else {
            fatalError("Invalid erosion level!")
        }
    }
}
