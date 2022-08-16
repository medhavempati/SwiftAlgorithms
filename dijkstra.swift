import Foundation

let graph: [String: [String: Int]] = [
    "A": ["B": 2, "C": 4],
    "B": ["A": 2, "C": 3, "D": 8],
    "C": ["A": 4, "B": 3, "E": 5, "D": 2],
    "D": ["B": 8, "C": 2, "E": 11, "F": 22],
    "E": ["C": 5, "D": 11, "F": 1],
    "F": ["D": 22, "E": 1],
]

func rearrange(_ heap: inout [(String, Int)], _ idx: Int) {
    let parentIdx = (idx-1)/2
    if parentIdx < 0 { return }
    if heap[idx].1 < heap[parentIdx].1 {
        // swap
        heap.swapAt(idx, parentIdx)
        rearrange(&heap, parentIdx)
    }
    return
}

func heapify(_ heap: inout [(String, Int)]) {
    for i in (0..<heap.count).reversed() {
        rearrange(&heap, i)
    }
    return
}


func dijkstra(_ graph: [String: [String: Int]], _ src: String, _ dest: String) -> Int {
    let inf = Int(UInt8.max)
    var heap: [(String, Int)] = []
    var nodeData = [
        "A": (cost: inf, pred: []),
        "B": (cost: inf, pred: []),
        "C": (cost: inf, pred: []),
        "D": (cost: inf, pred: []),
        "E": (cost: inf, pred: []),
        "F": (cost: inf, pred: [])
    ]
    // print(nodeData["A"]?.cost)

    var current = src
    var visited: [String] = []

    // append source node with cost 0 to heap 
    nodeData[current]?.cost = 0
    heap.append((current, 0))
    // for i in range n-1
    for _ in 0..<(nodeData.count-1) {
        // if not visited
        print(current)
        if !visited.contains(current) {
            visited.append(current)
        }
        
        //get neighbors of current
        guard let neighbors = graph[current] else { continue }
        for neighbor in neighbors {
            if !visited.contains(neighbor.key) {
                // calculate cost
                let cost = nodeData[current]!.cost + neighbor.value
                // update cost, pred
                if cost < nodeData[neighbor.key]!.cost {
                    nodeData[neighbor.key]!.cost = cost
                    nodeData[neighbor.key]!.pred.append(current)
                }
                // append to heap
                if let idx = heap.firstIndex(where: {$0.0 == neighbor.key}) {
                    if let cost = nodeData[neighbor.key]?.cost {
                        heap[idx].1 = cost
                    }
                }
                else { 
                    if let cost = nodeData[neighbor.key]?.cost {
                        heap.append((neighbor.key, cost))
                    }
                }
            }
        } 
        //heapify
        heap.removeFirst()
        print(heap)
        heapify(&heap)
        print("--- after heapify")
        print(heap)
        //update current node
        let closest = heap[0]
        current = closest.0
    }
    return nodeData[dest]?.cost != inf ? nodeData[dest]!.cost : -1

}

print(dijkstra(graph, "A", "F"))