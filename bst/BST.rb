require 'debugger'
require 'colorize'

class TreeNode
  attr_accessor :data, :left, :right
  def initialize(node_data = nil)
    @data = node_data
  end
end

def insert_recursive(treeNode, new_data)
  if treeNode.data.nil?
    treeNode.data = new_data
  elsif treeNode.data > new_data
    treeNode.left = TreeNode.new() if treeNode.left.nil? 
    insert_recursive(treeNode.left, new_data)
  else 
    treeNode.right = TreeNode.new() if treeNode.right.nil? 
    insert_recursive(treeNode.right, new_data)
  end
end

def search(treeNode, data)
  debugger
  if treeNode.nil? || treeNode.data.nil? 
    return false
  elsif treeNode.data == data
    return true
    #this is when the root of the original tree is the node to be deleted
  elsif treeNode.data > data
    search(treeNode.left, data)
  else
    search(treeNode.right, data)
  end
end

def delete(treeNode, data)
  if treeNode.nil? || treeNode.data.nil? 
    return treeNode
  elsif treeNode.data == data
    # have to delete the ndoe and replace it with inorder processor or successor 
  elsif treeNode.data > data
    delete(treeNode.left, data)
  else
    delete(treeNode.right, data)
  end
end

def inorder_print(treeNode)
  inorder_print(treeNode.left) if treeNode.left
  puts treeNode.data
  inorder_print(treeNode.right) if treeNode.right
end

def preorder_print(treeNode)
  puts treeNode.data
  preorder_print(treeNode.left) if treeNode.left
  preorder_print(treeNode.right) if treeNode.right
end

def postorder_print(treeNode)
  postorder_print(treeNode.left) if treeNode.left
  postorder_print(treeNode.right) if treeNode.right
  puts treeNode.data
end

def max(treeNode)
  return treeNode.data if treeNode.right.nil?
  max(treeNode.right)
end

def min(treeNode)
  return treeNode.data if treeNode.left.nil?
  min(treeNode.left) 
end

# need to write to get the parent of a node, dont' feel like writing it now
def inorder_successor(treeNode, node)
  if node.left
    node = node.left
    while node.right
      node = node.right
    end
    return node
  else
    # return it's parents 
  end
end


# need to write to get the parent of a node, dont' feel like writing it now
def inorder_predecessor(treeNode, node)
  if node.right
    node = node.right
    while node.left
      node = node.left
    end
    return node
  else
    # return it's parent
  end

end



treeNode = TreeNode.new(50)
20.times.each do |i|
  insert_recursive(treeNode, rand(1..100))
end

puts "inorder traversal".blue
inorder_print(treeNode)

puts "preorder traversal".blue
preorder_print(treeNode)

puts "postorder traversal".blue
postorder_print(treeNode)

puts "min".blue
puts min(treeNode)

puts "max".blue
puts max(treeNode)

s = 10
puts "searchign for #{s}".blue
puts search(treeNode, s)

puts "deleting 50".blue
puts delete(treeNode, 50)
