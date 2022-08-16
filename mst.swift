import Foundation

let graph: [String: [String: Int]] = [
    "A": ["B": 2, "C": 4],
    "B": ["A": 2, "C": 3, "D": 8],
    "C": ["A": 4, "B": 3, "E": 5, "D": 2],
    "D": ["B": 8, "C": 2, "E": 11, "F": 22],
    "E": ["C": 5, "D": 11, "F": 1],
    "F": ["D": 22, "E": 1],
]

func rearrange(_ heap: inout [(node: String, weight: Int)], _ idx: Int) {
    let parentIdx = (idx-1)/2
    if parentIdx < 0 { return }
    if heap[idx].weight < heap[parentIdx].weight {
        // swap
        heap.swapAt(idx, parentIdx)
        rearrange(&heap, parentIdx)
    }
    return
}

func heapify(_ heap: inout [(node: String, weight: Int)]) {
    for i in (0..<heap.count).reversed() {
        rearrange(&heap, i)
    }
    return
}

func prims(_ graph: [String: [String: Int]], _ source: String) -> [String:(Int, String)] {
    var mstSet: [String: Bool] = [:] // serves as visited set
    var heap: [(node: String, weight: Int)] = []
    var nodeData = [
        "A": (cost: Int.max, pred: ""),
        "B": (cost: Int.max, pred: ""),
        "C": (cost: Int.max, pred: ""),
        "D": (cost: Int.max, pred: ""),
        "E": (cost: Int.max, pred: ""),
        "F": (cost: Int.max, pred: "")
    ]

    // Initialize data for all nodes
    for i in graph {
        mstSet[i.key] = false
    }

    // Initialize data for source node
    nodeData[source]?.cost = 0
    heap.append((node: source, weight: 0))

    for i in (0..<(graph.count-1)).reversed() {
        // pop root of heap
        let current = heap[0]
        heap.removeFirst()
        // add node to mst set (mark visited)
        mstSet[current.node] = true
        // find neighbors of node
        guard let neighbors = graph[current.node] else { continue }
        for neighbor in neighbors {
            if mstSet[neighbor.key]! { continue }

            // if node not in heap, add node
            if !heap.contains(where: {$0.0 == neighbor.key}) {
                heap.append((node: neighbor.key, weight: nodeData[neighbor.key]!.cost))
            }
            // if weight less than existing weight, update in nodeData and heap
            guard let oldValue = nodeData[neighbor.key]?.cost else { continue }
            if neighbor.value < oldValue {
                nodeData[neighbor.key]?.cost = neighbor.value
                nodeData[neighbor.key]?.pred = current.node
                guard let idx = heap.firstIndex(where: {$0.0 == neighbor.key}) else { continue }
                heap[idx].weight = neighbor.value
            }
        }
        print(heap)
        heapify(&heap)
        print("-----")
        print(heap)        
    }
    return nodeData
}

print(prims(graph, "A"))