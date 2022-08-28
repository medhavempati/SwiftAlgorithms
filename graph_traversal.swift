import Foundation

let graph: [String:[String]] = [
    "a": ["b", "c"],
    "b": ["d"],
    "c": ["e"],
    "d": ["f"],
    "e": [],
    "f": []
]

let edges = [
    ["i", "j"],
    ["k", "i"],
    ["m", "k"],
    ["k", "l"],
    ["o", "n"],
]

struct Stack {
    var items: [String] = []

    func top() -> String {
        guard let top = self.items.first else {
            fatalError("Stack is empty")
        }
        return top
    }

    mutating func push(value: String) {
        self.items.insert(value, at:0)
    }

    mutating func pop() -> String {
        if self.items[0] == nil {
            fatalError("Stack is empty")
        }
        let result = self.items.removeFirst()
        return result
    }
}

struct Queue {
    var items: [String] = []

    mutating func push(_ value: String) {
        self.items.append(value)
    }

    mutating func pop() -> String {
        if self.items[0] == nil {
            fatalError("Stack is empty")
        }
        let result = self.items.removeFirst()
        return result
    }
}

struct AllPathsQueue {
    var items: [[String]] = []

    mutating func push(_ value: [String]) {
        self.items.append(value)
    }

    mutating func pop() -> [String] {
        if self.items[0] == nil {
            fatalError("Stack is empty")
        }
        let result = self.items.removeFirst()
        return result
    }
}

// print(graph)

func depthFirstSearch(graph: [String:[String]], source: String) {
    var stack = Stack()
    stack.push(value: source)

    while !stack.items.isEmpty {
        let currentNode = stack.pop()
        print(currentNode)

        guard let neighbors = graph[currentNode] else {
            continue
        }
        for neighbor in neighbors {
            stack.push(value: neighbor)
        }
    }

    print(stack)
}

func breadthFirstSearch(graph: [String: [String]], source: String) {
    var queue = Queue()
    queue.push(source)
    // print(queue)

    while !queue.items.isEmpty {
        let current = queue.pop()
        print(current)
        
        guard let neighbors = graph[current] else {
            continue
        }
        neighbors.forEach { queue.push($0) }
    }
}

func buildGraph( edges: [[String]] ) -> [String: [String]] {
    var graph: [String: [String]] = [:]
    for edge in edges {
        let a = edge[0]
        let b = edge[1]
        if graph[a] == nil { graph[a] = []}
        if graph[b] == nil { graph[b] = []}

        graph[a]?.append(b)
        graph[b]?.append(a)
    }
    return graph
}

func hasPath(graph: [String: [String]], source: String, dest: String, visited: inout Set<String>) -> Bool {
    // var visited: [String: Bool] = []
    // var stack = Stack()

    // // Initialize visited dict
    // for node in graph.keys {
    //     visited[node] = False
    // }
    // stack.push(source)

    if source == dest { return true }
    if visited.contains(source) { return false }

    visited.insert(source)

    guard let neighbors = graph[source] else {
        fatalError("Graph not found")
    }
    for neighbor in neighbors {
        if hasPath(graph: graph, source: neighbor, dest: dest, visited: &visited) {
            return true
        }
    }

    return false 


}

func undirectedPath(edges: [[String]], source: String, dest: String) -> Bool {
    let graph = buildGraph(edges: edges)
    var visited = Set<String>()
    return hasPath(graph: graph, source: source, dest: dest, visited: &visited)
    // return true
}

func findAllPathsBfs(_ graph: [String:[String]], _ start: String, _ dest: String) {
    var queue = AllPathsQueue()
    queue.push([start])
    while !queue.items.isEmpty {
        // print(queue)
        let current = queue.pop()
        // print(current)
        if current.last == dest { print(current) }
        else {
            guard let neighbors = graph[current.last!] else { return }
            for neighbor in neighbors {
                let temp = current + [neighbor]
                queue.push(temp)
            }
        }
    }
}

let allPathsGraph: [String: [String]] = [
    "0": ["1", "2", "3"],
    "1": ["3", "4"],
    "2": ["3"],
    "3": ["4"],
    "4": []
] 


// depthFirstSearch(graph: graph, source: "a")
// breadthFirstSearch(graph: graph, source: "a")
// var result = undirectedPath(edges: edges, source: "j", dest: "m")
// print(result)
findAllPathsBfs(allPathsGraph, "0", "4")
