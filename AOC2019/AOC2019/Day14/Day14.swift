import Foundation
import AdventOfCode

public final class Day14: Day {
	class NodeVertex {
		var name: String
		var quantity: Int
		
		init(name: String, quantity: Int) {
			self.name = name
			self.quantity = quantity
		}
	}
	
	class Node {
		var name: String
		let quantity: Int
		var edges: [NodeVertex]

		init(name: String, quantity: Int) {
			self.name = name
			self.quantity = quantity
			self.edges = []
		}
	}

	var input: [String] = []
	var nodes: [Node] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.input = input
	}

	public override func part1() -> String {
		let fuelNode = nodes.first(where: { $0.name == "FUEL" })!
		
		var productQuantity: [String: Int] = [:]
		
		var stack: [NodeVertex] = fuelNode.edges
		
		while !stack.isEmpty {
			let vertex = stack.removeFirst()
			productQuantity[vertex.name, default: 0] += vertex.quantity
			
			if let vertexThatSatisfiesTheEdges = nodes.first(where: { $0.name == vertex.name }) {
				productQuantity[vertexThatSatisfiesTheEdges.name, default: 0] += vertexThatSatisfiesTheEdges.quantity
				stack.append(contentsOf: vertexThatSatisfiesTheEdges.edges)
			}
		}

		return ""
	}

    public override func part2() -> String {
        fatalError()
    }
	
	// MARK: -
	
	private func parseNodes() {
		var allNodes: [Node] = []
		
		for line in input {
			let edgesToNode = line.components(separatedBy: " => ")
			let edgesLine = edgesToNode[0]
			let nodeLine = edgesToNode[1]
			
			let allEdges = edgesLine.components(separatedBy: ", ")
			let nodeEdges: [NodeVertex] = allEdges.reduce([], {
				let quantity = Int($1.split(separator: " ")[0])!
				let name = String($1.split(separator: " ")[1])
				return $0 + [NodeVertex(name: name, quantity: quantity)]
			})
			
			let nodeQuantity = Int(nodeLine.split(separator: " ")[0])!
			let nodeName = String(nodeLine.split(separator: " ")[1])
			let node = Node(name: nodeName, quantity: nodeQuantity)
			node.edges = nodeEdges
			allNodes.append(node)
		}
		self.nodes = allNodes
		
		for node in allNodes {
			print("> \(node.quantity) \(node.name) =>")
			
			var str = ""
			for edge in node.edges {
				str += "[\(edge.quantity) \(edge.name)] "
			}
			print(">>", str)
		}
	}
}
