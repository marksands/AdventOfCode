import Foundation

private class Node {
    fileprivate let childCount: Int
    fileprivate let metadataCount: Int
    
    fileprivate var children: [Node] = []
    fileprivate var metadataItems: [Int] = []
    
    fileprivate init(childCount: Int, metadataCount: Int) {
        self.childCount = childCount
        self.metadataCount = metadataCount
    }
    
    fileprivate func value() -> Int {
        if childCount == 0 {
            return metadataItems.sum()
        }
        return metadataItems.compactMap { children[safe: $0 - 1] }.reduce(0) { $0 + $1.value() }
    }
    
    fileprivate func allMetadataItems() -> [Int] {
        if metadataCount == 0 {
            return [0]
        }
        return children.reduce(into: []) { $0 += $1.allMetadataItems() } + metadataItems
    }
}

public final class Day8: Day {
    private let nums = Input().trimmedRawInput().components(separatedBy: .whitespaces).compactMap(Int.init)
    
    public override func part1() -> String {
        return "\(rootNode().allMetadataItems().sum())"
    }
    
    public override func part2() -> String {
        return "\(rootNode().value())"
    }
    
    private func rootNode() -> Node {
        let root = Node(childCount: 0, metadataCount: 0)
        var stack: [Node] = [root]
        
        var index = 0
        while index < nums.count {
            guard let parent = stack.last else { break }
            
            let childCount = nums[index]
            let metadataCount = nums[index+1]
            index += 2
            
            let node = Node(childCount: childCount, metadataCount: metadataCount)
            parent.children.append(node)
            
            if childCount > 0 {
                stack.append(node)
            } else {
                addMetadataItems(to: node, startingIndex: &index)
                
                while let parent = stack.last, parent.children.count == parent.childCount, parent.metadataItems.count != parent.metadataCount {
                    addMetadataItems(to: parent, startingIndex: &index)
                    stack.removeLast()
                }
            }
        }
        
        return root.children.first!
    }
    
    private func addMetadataItems(to node: Node, startingIndex index: inout Int) {
        (0..<node.metadataCount).forEach { _ in
            let item = nums[index]
            index += 1
            node.metadataItems.append(item)
        }
    }
}
