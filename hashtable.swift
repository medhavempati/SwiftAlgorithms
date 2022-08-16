import Foundation

struct Entry: Equatable {
    var key: String
    var value: String
    var hash: Int

    static func == (lhs: Entry, rhs: Entry) -> Bool {
        if lhs.hash != rhs.hash { return false }
        return (lhs.key == rhs.key)
    }

    init(key: String, value: String, hash: Int) {
        self.key = key
        self.value = value
        self.hash = hash
    }
}

class Hashtable {
    var defaultCapacity = 5
    var defaultLoadFactor = 0.75

    var maxLoadfactor: Double
    var capacity: Int 
    var threshold: Int  // capacity * size 
    var tableSize: Int = 0

    var table: [[Entry]] = []
    private var hashFunction: String

    init(_ function: String, _ capacity: Int, _ loadFactor: Double) {
        if capacity < 0 { fatalError("Invalid capacity") }
        if loadFactor <= 0 { fatalError("Invalid load factor") }
        self.hashFunction = function
        self.capacity = max(capacity, self.defaultCapacity)
        self.maxLoadfactor = loadFactor
        self.threshold = Int(Double(capacity) * loadFactor)
    }

    func insert(_ key: String, _ value: String) {
        // key operation, get hash
        var tempKey = String(key)
        var hash = 0

        // insert in table
        var newEntry = Entry(key: tempKey, value: value, hash: hash)
    } 
}


struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Chain = [Element]
    private var table: [Chain] = []

    init(_ capacity: Int) {
        assert(capacity > 0)
        table = Array<Chain>(repeating: [], count: capacity)
    }

    public subscript(key: Key) -> Value? {
        get {
            
        }
    }
}

