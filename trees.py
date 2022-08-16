
import struct


class Node:
    def __init__(self, value):
        self.value = value
        self.bf = 0
        self.left = None
        self.right = None

    def _get_left_weight(self, node, bf):
        if node.left == None:
            return bf

        bf += 1
        self._get_left_weight(self, node, bf)

    def get_balancing_factor(self):
        # get left bf
        # get right bf
        # calculate balancing
        return


class AVL_Tree:
    def __init__(self, root):
        self.root = root

    def balance(self):
        # get height function to get height of subtrees

        # loop through nodes from root
            # get heights and calculate balancing factor
            # check for each condition LL LR RL RR
            # have left rotate and right rotate functions
        pass

    def insert(self, node, new_node):
        if new_node.value > node.value:
            if node.right == None:
                node.right = new_node
            else:
                self.insert(node.right, new_node)

        else:
            #handle == case
            if node.left == None:
                node.left = new_node
            else:
                self.insert(node.left, new_node)

        return

    def insert_node(self, value):
        new_node = Node(value)
        self.insert(self.root, new_node)
        self.balance()
        return

    def delete(self, node, value):
        # change whole thing to search node.left and node.right instead of node itself

        if node == None:
            return None

        if node.value > value:
            # go left
            self.delete(node.left, value)


        if node.value < value:
            # go right 
            self.delete(node.right, value)
        
        # Case 1: Leaf node
        if node.left == None and node.right == None:
            if node.value == value:
                node = None
                return None
            else:
                return node
        
        if node.value == value:
            # Case 2: single child
            if node.left == None:
                node = node.right
            # for right == none

            # case 3: two children
            # find inorder successor of parent


        pass
    
    def delete_node(self, value):
        root = self.root
        
        self.delete(root, value)
        self.balance()
        return


    # TRAVERSALS
    def preorder(self, node):
        if node == None:
            return

        print(node.value)
        self.preorder(node.left)
        self.preorder(node.right)

    def inorder(self, node):
        if node == None:
            return

        self.inorder(node.left)
        print(node.value)
        self.inorder(node.right)

    def postorder(self, node):
        if node == None:
            return

        self.postorder(node.left)
        self.postorder(node.right)
        print(node.value)
        

def main():
    root_node = Node(25)
    tree = AVL_Tree(root_node)

    # tree.preorder(tree.root)

    tree.insert_node(30)
    tree.insert_node(20)
    tree.insert_node(23)
    tree.insert_node(22)

    tree.preorder(tree.root)

if __name__ == "__main__":
    main()