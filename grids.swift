import Foundation

let grid = [
    ["w", "l", "w", "w", "w"],
    ["w", "l", "w", "w", "w"],
    ["w", "w", "w", "l", "w"],
    ["w", "w", "l", "l", "w"],
    ["l", "w", "w", "l", "l"],
    ["l", "l", "w", "w", "w"]
]

func explore(_ grid: [[String]], _ source: (Int, Int), _ visited: inout Set<String>) -> Bool {
    // if out of bounds return false
    let rows = grid.count
    let cols = grid[0].count
    let (y, x) = source
    if y < 0 || y >= rows { return false }
    if x < 0 || x >= cols { return false }
    // if w return false
    if grid[y][x] == "w" { return false }

    // if visited return false
    let point = String(y) + "," + String(x)
    if visited.contains(point) { return false }
    visited.insert(point)

    // else
        // explore neighbors
    let neighbors = [(y-1, x), (y-1, x+1), (y, x+1), (y+1, x+1), (y+1, x), (y+1, x-1), (y, x-1), (y-1, x-1)]
    for neighbor in neighbors {
        explore(grid, neighbor, &visited)
    }
    return true
}


func numberOfIslands(_ grid: [[String]]) -> Int {
    // iterate through grid
    let rows = grid.count
    let cols = grid[0].count
    var visited = Set<String>()
    var count = 0
    
    for i in 0..<rows {
        for j in 0..<cols {
            // explore point
            if explore(grid, (i, j), &visited) {
                count += 1
            }
        }
    }
    return count
}

func getCount(_ grid: [[String]], _ source: (Int, Int), _ visited: inout Set<String>, _ size: inout Int) {
    // if out of bounds return false
    let rows = grid.count
    let cols = grid[0].count
    let (y, x) = source
    if y < 0 || y >= rows { return }
    if x < 0 || x >= cols { return }
    // if w return false
    if grid[y][x] == "w" { return }

    // if visited return false
    let point = String(y) + "," + String(x)
    if visited.contains(point) { return }
    visited.insert(point)

    // else
        // explore neighbors
    let neighbors = [(y-1, x), (y-1, x+1), (y, x+1), (y+1, x+1), (y+1, x), (y+1, x-1), (y, x-1), (y-1, x-1)]
    for neighbor in neighbors {
        getCount(grid, neighbor, &visited, &size)
    }
    size += 1
    return
}


func minimumIsland(_ grid: [[String]]) -> Int {
    // iterate through grid
    let rows = grid.count
    let cols = grid[0].count
    var visited = Set<String>()
    var size = rows * cols
    
    for i in 0..<rows {
        for j in 0..<cols {
            // explore point
            var tempSize = 0
            getCount(grid, (i, j), &visited, &tempSize)
            if tempSize < size && tempSize != 0 { size = tempSize }
        }
    }
    return size
}


print(minimumIsland(grid))
// print(numberOfIslands(grid))