public class LinkedList<Value>: Sequence, ExpressibleByArrayLiteral {

	// MARK: - Iterator

	public struct LinkedListIterator: IteratorProtocol {
		let list: LinkedList<Value>
		var cur: Node?

		init(list: LinkedList<Value>) {
			self.list = list
			self.cur = list.head
		}

		mutating public func next() -> Value? {
			defer { self.cur = self.cur?.next }
			return self.cur?.value
		}
	}

	// MARK: - Node

	class Node {
		var value: Value

		weak var prev: Node?
		var next: Node?

		init(value: Value, prev: Node? = nil, next: Node? = nil) {
			self.value = value
			self.prev = prev
			self.next = next

			prev?.next = self
		}
	}


	// MARK: - List

	private var head: Node?
	private var tail: Node?

	public private(set) var count: Int = 0

	public required init(arrayLiteral elements: Value...) {
		for element in elements {
			append(element)
		}
	}

	public init<C: Collection>(_ collection: C) where C.Element == Value {
		for element in collection {
			append(element)
		}
	}


	// MARK: - Public

	public func append(_ value: Value) {
		if count == 0 {
			head = Node(value: value)
			tail = head
		} else {
			tail = Node(value: value, prev: tail, next: nil)
		}

		count += 1
	}

	public func appending(_ value: Value) -> LinkedList {
		let list = LinkedList<Value>()
		for n in self {
			list.append(n)
		}
		list.append(value)
		return list
	}

	public func popFirst() -> Value? {
		guard count > 0 else { return nil }
		return remove(node: head!)
	}

	public func popLast() -> Value? {
		guard count > 0 else { return nil }
		return remove(node: tail!)
	}

	public func makeIterator() -> LinkedListIterator {
		return LinkedListIterator(list: self)
	}

	// MARK: - Private

	private func remove(node: Node) -> Value {
		count -= 1

		let value = node.value

		let prev = node.prev
		let next = node.next

		prev?.next = next
		next?.prev = prev

		if node === head { head = next }
		if node === tail { tail = prev }

		return value
	}
}

extension LinkedList: Equatable where Value: Equatable {
	public static func == (lhs: LinkedList<Value>, rhs: LinkedList<Value>) -> Bool {
		var i = lhs.makeIterator()
		var j = rhs.makeIterator()

		var allEqual = true
		while let a = i.next(), let b = j.next() {
			allEqual = allEqual && (a == b)
		}

		return allEqual
	}
}

extension LinkedList.Node: Equatable where Value: Equatable {
	static func == (lhs: LinkedList<Value>.Node, rhs: LinkedList<Value>.Node) -> Bool {
		return lhs.value == rhs.value
	}
}

extension LinkedList.Node: Hashable where Value: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(value)
	}
}

extension LinkedList: Hashable where Value: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(count)
		if let first = head?.value {
			hasher.combine(first)
		}
		if let last = tail?.value, head != tail {
			hasher.combine(last)
		}
	}
}
