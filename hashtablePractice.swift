import Foundation

func elementsWithSum(_ arr: [[Int]], _ sum: Int) -> Bool { 
    /* Finds an element from each of three rows such that the elements add up to sum */
    let (arr1, arr2, arr3) = (arr[0], arr[1], arr[2])

    // Store first set of differences
    var arr1_differences: [Int: Int] = [:]
    for i in 0..<arr1.count {
        let diff = sum - arr1[i]
        arr1_differences[diff] = arr1[i]
    }

    for (key, _) in arr1_differences {
        let tempSum = key
        var arr2_differences: [Int: Int] = [:]
        for i in 0..<arr2.count {
            let diff = tempSum - arr2[i]
            arr2_differences[diff] = arr2[i]
        }
        for i in 0..<arr3.count {
            if arr2_differences.keys.contains(arr3[i]) { return true }
        }
    }

    return false

}

// let arr = [
//     [1, 2, 3, 4, 5],
//     [2, 3, 6, 1, 2], 
//     [10, 10, 10, 10, 10]
// ]
// print(elementsWithSum(arr, 9))

func smallestSubarray(_ arr: [Int], _ k: Int) -> (Int, Int)? {
    /* returns start and end indicies of the smallest subarray with k distinct values */
    return (0, 0)
}

func gpTriplet(_ arr: [Int]) {

    for j in 1..<(arr.count-1) {
        var i = j-1
        var k = j+1
        // print("\(arr[i]), \(arr[j]), \(arr[k])")
        // print("\(i), \(j), \(k)")

        while (i >= 0) && (k <= arr.count-1) {

            // when triplet meets gp conditions
            while (arr[j] % arr[i] == 0) && (arr[k] % arr[j] == 0) && (arr[j]/arr[i] == arr[k]/arr[j]) {
                // print("condition 1")
                print("\(arr[i]), \(arr[j]), \(arr[k])")
                // print("\(i), \(j), \(k)")
                if i == 0 || k == arr.count - 1 { break }
                i -= 1
                k += 1
            }
            // when index reaches bounds, move onto next element as middle element
            // if i == 0 || k == arr.count - 1 { break }

            // when both are divisible, but not equal to the same value
            if (arr[j] % arr[i] == 0) && (arr[k] % arr[j] == 0) {
                // print("condition 2")
                // print("\(arr[i]), \(arr[j]), \(arr[k])")
                // print("\(i), \(j), \(k)")
                if arr[j]/arr[i] > arr[k]/arr[j] { k += 1 } 
                else { i -= 1 }
            }

            // when they are non divisible
            else if arr[j] % arr[i] == 0 { 
                k += 1 
                // print("condition 3 p1")
                // print("\(arr[i]), \(arr[j]), \(arr[k])")
                // print("\(i), \(j), \(k)")
            }
            else { 
                i -= 1 
                // print("condition 3 p2")
                // print("\(arr[i]), \(arr[j]), \(arr[k])")
                // print("\(i), \(j), \(k)")
            }
        }
    }

}

let arr = [2, 8, 10, 15, 16, 30, 32, 64]
gpTriplet(arr)