import Foundation

extension String {
    subscript(offset: Int) -> String {
        String(self[self.index(self.startIndex, offsetBy: offset)])
    }
    
    // func substring(fromIndex: Int) -> String {
    //     return self[min(fromIndex, self.count) ..< self.count]
    // }
}

// Fibonacci: time complexity = O(2n)
func fibonacciHelper(_ n: Int, _ memo: inout [Int]) -> Int {
    if memo[n] != 0 { return memo[n] }
    if n <= 2 { return 1 }
    memo[n] = fibonacciHelper(n-1, &memo) + fibonacciHelper(n-2, &memo)
    return memo[n]
}

func fibonacci(_ n: Int) -> Int {
    assert(n > 0)
    var memo = [Int](repeating: 0, count: n+1)
    return fibonacciHelper(n, &memo)
}

// print(fibonacci(30))

// Grid Traveler: O(m+n)
func gridTravelerHelper(_ n: Int, _ m: Int, _ memo: inout [String: Int]) -> Int {
    let key = String(n) + "," + String(m)
    if n == 0 || m == 0 { return 0 }
    if n == 1 || m == 1 { return 1 }
    if memo.keys.contains(key) { return memo[key]! }

    memo[key] = gridTravelerHelper(n-1, m, &memo) + gridTravelerHelper(n, m-1, &memo)
    let reverseKey = String(m) + "," + String(n)
    memo[reverseKey] = memo[key]
    return memo[key] ?? -1
}

func gridTraveler(_ n: Int, _ m: Int) -> Int {
    var memo: [String: Int] = [:]
    return gridTravelerHelper(n, m, &memo)
}

// print(gridTraveler(18, 18))

// canSum: given a number n and an array of numbers, return if its possible to add numbers in the array to get a sum of n
// O(mn)
func canSumHelper(_ n: Int, _ arr: [Int], _ memo: inout [Bool?]) -> Bool {
    if n == 0 { return true }
    if n < 0 { return false }
    if memo[n] != nil { return memo[n]! }

    for number in arr {
        let remainder = n - number
        memo[n] = canSumHelper(remainder, arr, &memo)
        if memo[n] == true { return true }
    }
    return false
}

func canSum(_ n: Int, _ arr: [Int]) -> Bool {
    var memo = [Bool?](repeating: nil, count: n+1)
    return canSumHelper(n, arr, &memo)
}

// print(canSum(7, [5, 3, 4, 7]))
// print(canSum(8, [2, 3, 5]))
// print(canSum(300, [7, 14]))


// howSum: 
func howSumHelper(_ n: Int, _ arr: [Int], _ memo: inout [[Int]?]) -> [Int]? {
    if n == 0 { return [] }
    if n < 0 { return nil }
    if memo[n] != nil { return memo[n] }

    for number in arr {
        // print(number)
        let remainder = n - number
        var result = howSumHelper(remainder, arr, &memo)
        // print(result)
        if var result = howSumHelper(remainder, arr, &memo) {
            result.append(number)
            memo[n] = result
            return result
        }
    }
    return nil
}

func howSum(_ n: Int, _ arr: [Int]) -> [Int]? {
    var memo = [[Int]?](repeating: nil, count: n+1)
    return howSumHelper(n, arr, &memo) 
}

// print(howSum(7, [5, 3, 4, 7]))
// print(howSum(1, [2, 3, 5]))
// print(howSum(300, [7, 14]))

func canConstruct(_ str: String, _ substrings: [String]) -> Bool {
    if str == "" { return true }

    for substring in substrings {
        var check = true
        var i = 0
        for i in 0..<substring.count {
            if substring[i] != str[i] { check = false; break}
        }

        // if check {
        //     let remaining = String(str[Range<String.Index>(i...)])
        //     if canConstruct(remaining, substrings) { return true }
        // }
    }
    return false 
}

// print(canConstruct("abcdef", ["ab", "abc", "cd", "def", "abcd"]))

func editDistance() {
    
}




