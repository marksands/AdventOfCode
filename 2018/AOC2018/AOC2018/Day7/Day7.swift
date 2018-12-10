import Foundation

public final class Day7: Day {
    private var dependencies: [String: [String]] = [:]
    private var stepRank: [String: Int] = [:]
    private var priorityQueue: [String] = []
    private var workers: [String: Int] = [:]
    private var totalTime = 0

    public override init() {
        super.init()

        let regex = Regex(pattern: "^Step (\\w) must be finished before step (\\w) can begin.$")
        
        Input().trimmedInputCharactersByNewlines()
            .map { regex.matches(in: $0)! }
            .forEach {
                dependencies[$0[1], default: []].append($0[2])
                stepRank[$0[2], default: 0] += 1
                stepRank[$0[1]] = stepRank[$0[1]] ?? 0
        }
        
        priorityQueue = stepRank.filter { $0.value == 0 }.map { $0.key }.sorted()
    }

    public override func part1() -> String {
        return topologicalSort(workerCount: 1)
    }
    
    public override func part2() -> String {
        _ = topologicalSort(workerCount: 5)
        return "\(totalTime)"
    }
    
    private func topologicalSort(workerCount: Int) -> String {
        var result = ""

        while priorityQueue.count > 0 || workers.keys.count > 0 {
            let (node, t) = workers.min(by: { $0.value < $1.value }) ?? ("", 0)
            workers.removeValue(forKey: node)
            
            totalTime = t
            result += node
            
            for child in dependencies[node] ?? [] {
                stepRank[child]? -= 1
                
                if stepRank[child] == 0 {
                    priorityQueue.append(child)
                    priorityQueue.sort()
                }
            }
            
            updateWorkers(maxWorkerCount: workerCount)
        }
        
        return result
    }
    
    private func updateWorkers(maxWorkerCount: Int) {
        while workers.keys.count < maxWorkerCount && priorityQueue.count > 0 {
            let node = priorityQueue.removeFirst()
            workers[node] = totalTime + 60 + uppercaseLetters.exploded().firstIndex(of: node)! + 1
        }
    }
}
