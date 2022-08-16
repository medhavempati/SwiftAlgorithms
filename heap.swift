import Foundation

// left child = i*2
// right child = i*2 + 1
// parent = i/2

class MinHeap {
    var heap: [Int] = []

    func getParent(_ idx: Int) -> Int {
        return heap[(idx-1)/2]
    }

    func getLeftChild(_ idx: Int) -> Int {
        return heap[idx*2 + 1]
    }

    func getRightChild(_ idx: Int) -> Int {
        return heap[idx*2 + 2]
    }

    func rearrange(_ idx: Int) {
        // compare with parent
        let parentIdx = (idx-1)/2
        if parentIdx < 0 { return }
        if heap[idx] < heap[parentIdx] {
            heap.swapAt(idx, parentIdx)
            rearrange(parentIdx)
        }
        return
    }

    func insert(_ value: Int) {
        // append value to array
        heap.append(value)
        // if smaller than parent, swap with parent, till root
        var newIdx = heap.count - 1
        rearrange(newIdx)
        return
    }

    func removeTop() {
        heap.removeFirst()
    }

    func remove(_ value: Int) {
        guard let index = (heap.firstIndex{$0 == value}) else { return }
        heap.swapAt(index, 0)
        removeTop()
        rearrange(index - 1)
    }
}

func rearrange(_ heap: inout [Int], _ idx: Int) {
    // compare with parent
        let parentIdx = (idx-1)/2
        if parentIdx < 0 { return }
        if heap[idx] < heap[parentIdx] {
            heap.swapAt(idx, parentIdx)
            rearrange(&heap, parentIdx)
        }
        return
}

func heapify(_ heap: inout [Int]) {
    // start at end of array
    // for len(array)
    for i in (0..<heap.count).reversed() {
        rearrange(&heap, i)
    }
}

func heapSort(_ heap: [Int]) -> [Int] {
    var outputSequence: [Int] = []
    var heap = heap
    // for len(heap)
    for i in 0..<heap.count {
        // heapify heap
        heapify(&heap)
        // add min element to output
        outputSequence.append(heap[0])
        // remove min element
        heap.removeFirst()
    }
    return outputSequence
}

func sortAlmostSortedArray(_ arr: [Int], _ k: Int) -> [Int] {
    var outputSequence = MinHeap()
    var heap: [Int] = Array(arr[0..<k-1])
    
    for i in k-1..<arr.count {
        heap.append(arr[i])
        heapify(&heap)
        outputSequence.insert(heap[0])
        heap.removeFirst()
    }  
    return outputSequence.heap
}



// let arr = [12, 11, 13, 5, 6, 7]
// print(heapSort(arr))

// var heap = MinHeap()
// heap.insert(8)
// heap.insert(10)
// heap.insert(12)
// heap.insert(4)
// heap.insert(11)
// heap.remove(10)
// print(heap.heap)

// let arr = [6, 5, 3, 2, 8, 10, 9]
// print(sortAlmostSortedArray(arr, 3))


