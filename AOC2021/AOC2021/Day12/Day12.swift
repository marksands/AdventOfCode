import Foundation
import AdventOfCode

public final class Day12: Day {
	class Node: Equatable, Hashable, CustomDebugStringConvertible {
		var name: String
		var nodes: [Node]
		
		init(name: String, nodes: [Node] = []) {
			self.name = name
			self.nodes = nodes
		}
		
		func hash(into hasher: inout Hasher) {
			hasher.combine(name)
		}
		
		static func ==(lhs: Node, rhs: Node) -> Bool {
			return lhs.name == rhs.name && lhs.nodes.count == rhs.nodes.count
		}
		
		var debugDescription: String {
			return "[\(name): \(nodes.count) Nodes]"
		}
	}
	
	var lines: [String] = []
		
	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
	}

    public override func part1() -> String {
		return pathCount(isPart1: true)
	}

    public override func part2() -> String {
		return pathCount(isPart1: false)
	}
	
	// TODO: This is very very slow. Optimize.
	private func pathCount(isPart1: Bool) -> String {
		var startNode: Node
		startNode = Node(name: "start")

		var nodes: [Node] = [startNode]
		for line in lines {
			let components = line.components(separatedBy: "-")
			let (left, right) = (components.first!, components.last!)
			
			let leftNode = nodes.first(where: { $0.name == left }) ?? Node(name: left)
			let rightNode = nodes.first(where: { $0.name == right }) ?? Node(name: right)
			
			if !leftNode.nodes.contains(where: { $0.name == rightNode.name }) {
				leftNode.nodes.append(rightNode)
			}
			
			if !rightNode.nodes.contains(where: { $0.name == leftNode.name }) {
				rightNode.nodes.append(leftNode)
			}
			
			if !nodes.contains(where: { $0.name == leftNode.name }) {
				nodes.append(leftNode)
			}
			if !nodes.contains(where: { $0.name == rightNode.name }) {
				nodes.append(rightNode)
			}
		}
		
		func isLowercaseCaveValidForTwoVisits(_ node: Node, path: [Node]) -> Bool {
			let isNotStartOrEnd = (node.name != "start" && node.name != "end")
			let allLowercasedCaves = path.filter { $0.name.lowercased() == $0.name }
			let hasTwoLowercasedCaves = allLowercasedCaves.countElements().anySatisfy { $0.value == 2 }
			
			return isNotStartOrEnd && !hasTwoLowercasedCaves
		}
		
		var paths = [[startNode]]
		var fullyResolvedPaths: [[Node]] = []
		while let topPath = paths.popFirst() {
			let front = topPath.last!
			for neighbor in front.nodes {
				if neighbor.name == "end" {
					let resolved = topPath + [neighbor]
					fullyResolvedPaths.append(resolved)
				} else if neighbor.name.lowercased() == neighbor.name, !isPart1, isLowercaseCaveValidForTwoVisits(neighbor, path: topPath) {
					let newPath = topPath + [neighbor]
					paths.append(newPath)
				} else if neighbor.name.lowercased() == neighbor.name, !topPath.contains(neighbor) {
					let newPath = topPath + [neighbor]
					paths.append(newPath)
				} else if neighbor.name.uppercased() == neighbor.name {
					let newPath = topPath + [neighbor]
					paths.append(newPath)
				}
			}
		}
	
		return fullyResolvedPaths.count.string
    }
}
