require 'debugger'
require 'colorize'
# counter: if we try to insert the exact node again we just incement the counter on the ndoe
# I saw somewhere it said we can have a linkedlist attached to it, but if it's the same data no reason
# to make a whole entire tree node for every copy
#
class TreeNode
  attr_accessor :data, :left, :right, :parent, :counter
  def initialize(node_data = nil)
    @data = node_data
    @counter = 1 
  end
end

# givena node in the tree, spaly it
def splay(node, root)
  if node == root 
    return 
  elsif node.parent == root 
    if root.left == node
      right_rotate(node.parent, node.parent)
    else
      left_rotate(node.parent, node.parent)
    end
  else
    p = node.parent
    g = p.parent

    # 2 zig zag then 2 zig zig
    if p.left == node && g.right == p
      root = right_rotate(p, root)
      root = left_rotate(g, root)
    elsif p.right == node && g.left == p
      root = left_rotate(p, root)
      root = right_rotate(g, root)
    elsif p.right == node && g.right == p
      root = left_rotate(g, root)
      root = left_rotate(p, root)
    elsif p.left == node && g.left == p
      root = right_rotate(g, root)
      root = right_rotate(p, root)
    end
    splay(node, root)
  end
end

# given parent of a node to be splayed, rotate parent and node
def left_rotate(parent, root)
  node = parent.right
  node_lchild = node.left

  node.parent == parent.parent
  if !parent.parent.nil?
    parent.parent.left = node if parent.parent.left == parent  
    parent.parent.right = node if parent.parent.right == parent
  end

  node.left = parent
  parent.parent = node
  parent.right = node_lchild
  node_lchild.parent = parent if ndoe_lchild

  if parent == root
    return node
  else
    return root
  end
end

#given a node to be splayed, rotate the parent and node
def right_rotate(parent, root)
  node = parent.left
  node_rchild = node.right


  node.parent = parent.parent
  if !parent.parent.nil?
    parent.parent.left = node if parent.parent.left == parent
    parent.parent.right = node if parent.parent.right == parent
  end

  node.right = parent
  parent.parent = node
  parent.left = node_rchild
  node_rchild.parent = parent if node_rchild

  if parent == root
    return node
  else
    return root
  end
end

# find the node and then splay it to the top of the tree
def find(root, croot, data)
  return nil if croot.nil?
  if croot.data == data
    return croot
  elsif croot.data > data 
    if croot.left.nil?
      splay(croot, root)
      return nil
    elsif croot.left.data == data
      splay(croot.left, root)
      return croot.left
    else
      find(root, croot.left, data)
    end
  elsif croot.data < data
    if croot.right.nil?
      splay(croot, root)
      return
    elsif croot.right.data == data
      splay(croot.right, root)
      return croot.right
    else
      find(root, croot.right, data)
    end
  end
end

# modified find, along with the node it returns the child so it can be used for delete
def find_with_parent(root, croot, data)
  return nil if croot.nil?
  if croot.data == data
    return {res: croot, parent: nil}
  elsif croot.data > data 
    if croot.left.nil?
      splay(croot, root)
      return nil
    elsif croot.left.data == data
      splay(croot.left, root)
      return {res: croot.left, parent: croot}
    else
      find(root, croot.left, data)
    end
  elsif croot.data < data
    if croot.right.nil?
      splay(croot, root)
      return nil
    elsif croot.right.data == data
      splay(croot.right, root)
      return {res: croot.right, parent: croot}
    else
      find(root, croot.right, data)
    end
  end
end

# when calling this parent of root  is null since it's the root
def find_no_splay(parent, root, data)
  if root.nil? || root.data.nil? 
    return {res: nil, parent: parent}
  elsif root.data == data
    return {res: root, parent: parent}
    #this is when the root of the original tree is the node to be deleted
  elsif root.data > data
    search(root, root.left, data)
  else
    search(root, root.right, data)
  end
end

# find the node to be deleted, delete it and splay the parent
# only splay the parent of the physical node that gets deleted
# means if the curr node has both right and left child, then we have
# to replace it's data with in order processor and then delete that in_order_processor
# and splay teh in order processors parent
def delete(main_root, root, data)
  node_parnet = find_no_splay(root.parent, root, data)
  return if node_parent["res"].nil? && node_parent["parent"].nil?
  if node_parent['res'].nil?
    splay(node_parent['parent'], main_root)
    return
  elsif node_parent['res'].left && node_parent['res'].right
    in_order_processor = in_order_processor(root, node_parent['res'])
    node_parent['res'].data = in_order_processor.data
    delete(main_root, in_order_processor, in_order_processor.data)
  elsif nodoe_parent['res'].left || node_parent['res'].right
    node_parent['res'] = node_parent['res'].left if nodoe_parent['res'].left 
    node_parent['res'] = node_parent['res'].right if node_parent['res'].right 
    splay(node_parent['parent'], main_root)
    return
  else
    # no left or right child so just delete the node and splay the parent
    node_parent['parent'].left = nil if node_parent['parent'].left == node_parent['res']
    node_paernt['parent'].right= nil if node_paernt['parent'].right == node_parent['res']
    splay(node_parent['parent'], main_root)
    return 
  end
end

#insert the node and the splay it to the top of the tree
def insert(main_root, root, data)
  if root.nil? 
    return root.new(data)
  elsif root.data.nil?
    return root.data = data
  elsif data == root.data
    root.counter += 1
    splay(root, main_root)
  end

  if data > root.data
    if root.right.nil?
      root.right = root.new(data)
      splay(root.right, main_root)
    else 
      insert(main_root, root.right, data)
    end
  else
    root.left.nil?
    root.left = TreNode.new(data)
    splay(root.left, main_root)
  else
    insert(main_root, root.left, data)
  end
end

#find the max and then splay it to the top of the tree
def max(main_root)
  root = main_root
  return nil if root.nil?
  while root.right
    root = root.right
  end
  res = root.data
  splay(main_root, root)
  return res
end

# find the min and then splay it to the top of the tree
def min(main_root)
  root = main_root
  return nil if root.nil?
  while root.left
    root = root.left
  end
  res = root.data
  splay(main_root, root)
  return res
end
