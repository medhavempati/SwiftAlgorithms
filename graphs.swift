import Foundation

let graph: [Int: [Int]] = [
    0: [8, 1, 5],
    1: [0],
    5: [0, 8],
    8: [0, 5],
    2: [3, 4],
    3: [2, 4],
    4: [3, 2]
]

let edges = [
    ["w", "x"],
    ["x", "y"],
    ["z", "y"],
    ["z", "v"],
    ["w", "v"]
]

struct Queue {
    var items: [(String, Int)] = []

    mutating func push(_ value: (String, Int)) {
        self.items.append(value)
    }

    mutating func pop() -> (String, Int) {
        if self.items[0] == nil {
            fatalError("Stack is empty")
        }
        let result = self.items.removeFirst()
        return result
    }
}

func traverse(_ graph: [Int: [Int]], _ source: Int, _ visited: inout Set<Int>) {
    if visited.contains(source) {return}
    visited.insert(source)

    guard let neighbors = graph[source] else {
        return
    }
    for neighbor in neighbors {
        traverse(graph, neighbor, &visited)
    }
    return
}

func numberOfConnectedComponents(_ graph: [Int: [Int]]) -> Int {
    // iterate through nodes in graph
    var visited = Set<Int>()
    var components = 0

    for node in graph.keys {
        // if node is visited, move onto next node
        if visited.contains(node) { continue }
        // perform traversal 
        traverse(graph, node, &visited)
        // increase count when done
        components += 1
        
    }

    return components
}

func getSizeOfComponent(_ graph: [Int: [Int]], _ source: Int, _ visited: inout Set<Int>, _ count: inout Int) {
    if visited.contains(source){ return }
    visited.insert(source)
    count += 1

    guard let neighbors = graph[source] else { return }
    for neighbor in neighbors {
        getSizeOfComponent(graph, neighbor, &visited, &count)
    }
    return
}

func largestComponent(_ graph: [Int: [Int]]) -> Int {
    var visited = Set<Int>()
    var maxSize = 0

    // iterate through nodes
    for node in graph.keys {
        // if node is visited move onto next
        if visited.contains(node){ continue }
        // traverse, get size of component
        var count = 0
        getSizeOfComponent(graph, node, &visited, &count)
        // update max size
        if count > maxSize { maxSize = count }
    }
    return maxSize
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

func shortestPath(_ edges: [[String]], _ source: String, _ dest: String) {
    // convert edge list to adj list
    let graph = buildGraph(edges: edges)

    // initialize queue
    var queue = Queue()
    queue.push((source, 0))
    var visited = Set<String>()
    visited.insert(source)

    guard let neighbors = graph[source] else { return }
    // start at source node
    while !queue.items.isEmpty {
        // pop next node
        let (node, dist) = queue.pop()
       
        if node == dest { 
            print(dist) 
            break
        }
        // add neighbors to queue
        guard let neighbors = graph[node] else { return }
        for neighbor in neighbors {
            if visited.contains(neighbor) {
                continue
            }
            visited.insert(neighbor)
            queue.push((neighbor, dist + 1))
        }
    }
    return
}

// print(numberOfConnectedComponents(graph))
// print(largestComponent(graph))
shortestPath(edges, "w", "z")