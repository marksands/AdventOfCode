import Foundation

class Node {
    let childCount: Int
    let metadataCount: Int
    
    weak var parent: Node?
    var children: [Node] = []
    var metadataItems: [Int] = []
    
    init(childCount: Int, metadataCount: Int, parent: Node?) {
        self.childCount = childCount
        self.metadataCount = metadataCount
        self.parent = parent
    }
    
    func value() -> Int {
        if childCount == 0 {
            return metadataItems.sum()
        }
        return metadataItems.compactMap { children[safe: $0 - 1] }.reduce(0) { $0 + $1.value() }
    }
    
    func allMetadataItems() -> [Int] {
        if metadataCount == 0 {
            return [0]
        }
        return children.reduce(into: []) { $0 += $1.allMetadataItems() } + metadataItems
    }
    
    var canBeSatisfied: Bool {
        return children.count == childCount && metadataItems.count != metadataCount
    }
}

public final class Day8: Day {
    private let nums: [Int]

    public init(input: [Int] = Input().trimmedRawInput().components(separatedBy: .whitespaces).compactMap(Int.init)) {
        self.nums = input
        super.init()
    }
    
    public override func part1() -> String {
        return "\(rootNode().allMetadataItems().sum())"
    }
    
    public override func part2() -> String {
        return "\(rootNode().value())"
    }
    
    private func rootNode() -> Node {
        let root = Node(childCount: 0, metadataCount: 0, parent: nil)
        var stack: [Node] = [root]
        
        var index = 0
        var MDI = 0
        
        func addMetadataItems(to node: Node, startingIndex index: inout Int) {
            (0..<node.metadataCount).forEach { _ in
                let item = nums[index]
                MDI += item
                index += 1
                node.metadataItems.append(item)
            }
        }
        
        while index < nums.count && stack.count > 0 {
            guard let parent = stack.last else { break }
            
            let childCount = nums[index]
            let metadataCount = nums[index+1]
            index += 2
            
            let node = Node(childCount: childCount, metadataCount: metadataCount, parent: parent)
            parent.children.append(node)
            
            if childCount > 0 {
                stack.append(node)
            } else {
                addMetadataItems(to: node, startingIndex: &index)
                
                while let parent = stack.last, parent.canBeSatisfied {
                    addMetadataItems(to: parent, startingIndex: &index)
                    stack.removeLast()
                }
            }
        }
        
        return root.children.first!
    }
}
