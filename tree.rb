# given the preorder and inorder of a binary tree, build the tree
# preorder: "fbadcegih"
# inorder: "abcdefghi"
# t = Tree.new('fbadcegih', 'abcdefghi')
# t.build_tree
# t.to_s
class Node
  attr_accessor :data, :left, :right
  def initialize(data)
    @data = data
  end
end
class Tree
  attr_accessor :root
  def initialize(preorder, inorder)
    @preorder = preorder
    @inorder = inorder
    @root = Node.new(preorder[0])
    @preorder_result = []
  end

  def build_tree
    i = @inorder.index(@root.data)
    if i == 1 and @inorder.length < 3
      @root.left = Node.new(@inorder[0])
      @root.right = Node.new(@inorder[2]) unless @inorder[2] == nil
    else
      unless i == 0
        left_preorder = @preorder[1..i]
        left_inorder = @inorder[0..i-1]
        left_tree = Tree.new(left_preorder, left_inorder)
        @root.left = left_tree.root
        left_tree.build_tree
      end
      unless i == @inorder.length - 1
        right_preorder = @preorder[i+1..-1]
        right_inorder = @inorder[i+1..-1]
        right_tree = Tree.new(right_preorder, right_inorder)
        @root.right = right_tree.root
        right_tree.build_tree
      end
    end
  end

  # print tree in preorder
  def preorder_array(node)
    return if node == nil
    #store visited node data
    @preorder_result << node.data
    preorder_array(node.left)
    preorder_array(node.right)
  end

  def to_s
    preorder_array(@root)
    @preorder_result.join
  end
end
