import Foundation

class Node: Equatable {
    var value: Int
    var height: Int
    var neighbors: [Node?]   // [leftChild, rightChild, parent]

    init(val: Int) {
        value = val
        neighbors = [nil, nil]
        height = 1
    }

    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.value == rhs.value
    }

    func left() -> Node? { return neighbors[0] }
    func setLeft(_ node: Node?) { neighbors[0] = node}

    func right() -> Node? { return neighbors[1] }
    func setRight(_ node: Node?) { neighbors[1] = node}

    func parent() -> Node? { return neighbors[2] }
    func setParent(_ node: Node?) { neighbors[2] = node}
}

class AVLTree {
    var root: Node

    init(value: Int) {
        let rootNode = Node(val: value)
        self.root = rootNode
        self.root.height = 1
        self.root.setParent(nil)
    }

    func leftRotate(_ currentNode: Node) -> Node {
        guard let rightNode = currentNode.right() else { fatalError() }
        let parent = currentNode.parent()
        // change child for parent
        let idx = parent?.neighbors.firstIndex(where: {$0 == currentNode})
        switch idx {
        case 0:
            parent?.setLeft(rightNode)
        case 1:
            parent?.setRight(rightNode)
        default:
            break
        }

        // change parents
        rightNode.setParent(parent)
        currentNode.setParent(rightNode)

        // change children
        currentNode.setRight(rightNode.left() ?? nil)
        rightNode.setLeft(currentNode)

        return rightNode
    }

    func rightRotate(_ currentNode: Node) -> Node {
        guard let leftNode = currentNode.left() else { fatalError()} 
        let parent = currentNode.parent()

        // change child for parent
        let idx = parent?.neighbors.firstIndex(where: {$0 == currentNode})
        switch idx {
        case 0:
            parent?.setLeft(leftNode)
        case 1:
            parent?.setRight(leftNode)
        default:
            break
        }

        // change parents
        leftNode.setParent(parent)
        currentNode.setParent(leftNode)

        // change children
        currentNode.setLeft(leftNode.right() ?? nil)
        leftNode.setRight(currentNode)

        return leftNode
    }

    func rearrange(_ node: Node) {
        let leftHeight = node.left()?.height ?? 0
        let rightHeight = node.right()?.height ?? 0
        var finalNode: Node = node

        if abs(leftHeight - rightHeight) > 1 {

            // left imbalance
            if leftHeight > rightHeight {
                let ll = node.left()!.left()?.height ?? 0      // left left height
                let lr = node.left()!.right()?.height ?? 0     // left right height

                // left left case
                if ll > lr {
                    finalNode = rightRotate(node)
                }

                // left right case
                else if lr > ll {
                    // left right rotate
                    _ = leftRotate(node.left()!)
                    finalNode = rightRotate(node)
                }

            }

            // right imbalance
            else if rightHeight > leftHeight {
                let rl = node.right()!.left()?.height ?? 0
                let rr = node.right()!.right()?.height ?? 0

                // right left case
                if rl > rr {
                    _ = rightRotate(node.right()!)
                    finalNode = leftRotate(node)
                }

                // right right case
                else if rr > rl {
                    finalNode = leftRotate(node) 
                }
            }
        }
        else { finalNode = node }
        
        // finalNode is the new node in the place of the original input 'node' after rearrangement
        if finalNode.parent() == nil { 
            self.root = finalNode
            return 
        }
        rearrange(finalNode.parent()!)
    }

    func insert(_ newValue: Int, _ current: Node) {
        current.height += 1

        // Left
        if newValue > current.value {   
            // new node
            if current.left() == nil {
                let newNode = Node(val: newValue)
                current.setLeft(newNode)
            }
            else { self.insert(newValue, current.left()!)}
        }

        // Right
        else { 
            // new node 
            if current.right() == nil {
                let newNode = Node(val: newValue)
                current.setRight(newNode)
            }
            else { self.insert(newValue, current.right()!)}
        }

        rearrange(current)
        return
    }

    func preorder(_ currentNode: Node?) {
        if currentNode == nil { return }
        print(currentNode!.value)
        preorder(currentNode!.left())
        preorder(currentNode!.right())
    }

    func inorder(_ currentNode: Node?) {
        if currentNode == nil { return }
        inorder(currentNode!.left())
        print(currentNode!.value)
        inorder(currentNode!.right())
    }
}

let tree = AVLTree(value: 10)
// tree.insert(12, tree.root)
// tree.insert(8, tree.root)
// tree.preorder(tree.root)

// tree.insert(5, tree.root)
// tree.insert(6, tree.root)
// tree.preorder(tree.root)