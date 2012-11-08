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

def search_with_parent(parent, treeNode, data)
  if treeNode.nil? || treeNode.data.nil?
    return {parent: nil, treeNode: treeNode} 
  elsif treNode.data == data
    return {parent: parent, treeNode: treeNode}
  elsif treeNode.data > data
    search_with_parent(treeNode, treeNode.left, data)
  else
    search_with_parent(treeNode, treeNode.right, data)
  end
end

def delete(treeNode, data)
  res = search_with_parent(nil, treeNode, data)
  delete_node(res[:parent], res[:treeNode])
end

def delete_node(parent, node)
  if node.left.nil? && node.right.nil?
    if parent.left.data == node.data
      parent.left = nil
    else
      parent.right = nil
    end
  elsif node.left.nil? || node.right.nil?
    node = node.left.nil? ? node.right : node.left
  else 
    max_node = max(node.left)
    node.data = max_node.data
    delete_node(nil, max_node) 
  end
end

def inorder_print(treeNode)
  inorder_print(treeNode.left) if treeNode.left
  puts treeNode.data
  inorder_print(treeNode.right) if treeNode.right
end

def inorder_print_itr(treeNode) 
  stack = []
  curr_node = treeNode
  done = false

  while !done
    if curr_node
      stack.push(curr_node)
      curr_node = curr_node.left
    else
      if stack.empty?
        done = true
      else
        val = stack.pop
        puts val.data
        curr_node = val.right
      end
    end
  end
end



def preorder_print(treeNode)
  puts treeNode.data
  preorder_print(treeNode.left) if treeNode.left
  preorder_print(treeNode.right) if treeNode.right
end

def preorder_print_itr(treeNode)
  curr_node = treeNode;
  done = false;
  stack = []

  while !done
    if curr_node
      puts curr_node.data
      stack.push curr_node
      curr_node = curr_node.left
    else
      if stack.empty?
        done = true
      else
        val = stack.pop
        curr_node = val.right
      end
    end
  end
end


def postorder_print(treeNode)
  postorder_print(treeNode.left) if treeNode.left
  postorder_print(treeNode.right) if treeNode.right
  puts treeNode.data
end

def postorder_print_itr(treeNode)
  return if !treeNode
  prev = nil;
  stack = [treeNode]

  while !stack.empty?
    curr = stack.last

    if !prev || prev.left == curr || prev.right == curr 
      if curr.left
        stack.push(curr.left)
      elsif curr.right
        stack.push(curr.right) 
      end
    elsif curr.left == prev
      stack.push(curr.right) if curr.right
    else
      puts curr.data
      stack.pop()
    end
      
    prev = curr
  end
end

# wronte!
def postorder_print_itr_helper(curr_node, stack, done)

  while !done
    if curr_node
      stack.push curr_node
      curr_node = curr_node.left
    else
      if stack.empty?
        done = true
      else
        val = stack.pop
        curr_node = val.right
        puts val.data
      end
    end
  end
end

# we need to return at every stage, because if we don't then first time around
# it hits 0 and returns from that call, but all the other calls don't return so
# it keeps calling the other calls and decrement the counter 
def nth_inorder_node(treeNode, counter)
  # Check left node
  if treeNode.left
    rv = nth_inorder_node(treeNode.left, counter)
    return rv if rv
  end

  # Check current node
  counter.value -= 1
  puts "counter: #{counter.value} \t node: #{treeNode.data}".green
  return treeNode.data if counter.value == 0

  # Check right node
  if treeNode.right
    rv = nth_inorder_node(treeNode.right, counter)
    return rv if rv
  end

  return nil
end

def max(treeNode)
  return treeNode.data if treeNode.right.nil?
  max(treeNode.right)
end

def min(treeNode)
  return treeNode.data if treeNode.left.nil?
  min(treeNode.left) 
end

def height(treeNode)
  return 0 if treeNode.nil?
  return [height(treeNode.left), height(treeNode.right)].max + 1
end

def min_depth(treeNode)
  return 0 if treeNode.nil?
  return [height(treeNode.left), height(treeNode.right)].min + 1
end

def is_balanced?(treeNode)
  height = height(treeNode)
  min_depth = min_depth(treeNode)
  (height - min_dpth) >= 1
end

def total_nodes(treeNode)
  return 0 if treeNode.nil? 
  return 1 + total_nodes(treeNode.left) + total_nodes(treeNode.right)
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
    # return it's parents if it's larger than the node 
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
    # return it's parent if it's smaller than the node
  end

end

# if their in order traversal matches
def match(t1, t2)
  return true if t1.nil? && t2.nil?
  return false if t1.nil? || t2.nil?

  return match(t1.left, t2.left)  
  return t1.data == t2.data
  return match(t1.right, t2.right)
end

def tree_to_ll_inorder(tree)
  head = Ll.new()
  ttoll_inorder_helper(tree, head)
  return head
end

def ttoll_inorder_helper(tree, ll)
  return if tree.nil?
  tree_to_ll_inorder(tree.left, ll)

  # head
  if ll.data.nil?
    ll.data = tree.data
  else
    ll.next = Ll.new(tree.data)
    tmp = ll.next
    tmp.prev = ll
    ll = tmp
  end
  
  tree_to_ll_inorder(tree.right, ll)
end


treeNode = TreeNode.new(50)
20.times.each do |i|
  val = rand(1..100)
  puts val
  insert_recursive(treeNode, val)
end

class IntegerClass 
  attr_accessor :value
  def initialize(val)
    @value = val
  end
end

#puts "inorder traversal".blue
#inorder_print(treeNode)
#puts "inorder traversal iterative: ".blue
#inorder_print_itr(treeNode)

#puts "preorder traversal".blue
#preorder_print(treeNode)
#puts "preorder traversal itr".blue
#preorder_print_itr(treeNode)


puts "postorder traversal".blue
postorder_print(treeNode)
puts "postorder traversal itr".blue
#postorder_print_itr(treeNode)

#puts "min".blue
#puts min(treeNode)

#puts "max".blue
#puts max(treeNode)

#s = 10
#puts "searchign for #{s}".blue
#puts search(treeNode, s)

#puts "deleting 50".blue
#puts delete(treeNode, 50)

puts "5th in order".blue
counter = IntegerClass.new(5)
puts nth_inorder_node(treeNode, counter)

#puts match(treeNode, treeNode)
