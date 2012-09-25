# this is an example file where I use my graph library + pinterest crawler data

require 'json'
require 'debugger'
require_relative 'graph_node'

class Graph < Hash

  def initialize
  end

  def insert_pinterest_users(total_nodes = nil) 
    create_pinterest_user_graph(total_nodes)
  end

  def bfs(key)
    queue = []

    clear_params
    curr_node = self[key] 
    curr_node.color = gray
    curr_node.distance = 0
    curr_node.parent = nil
    queue << curr_node

    while queue.size > 0
      curr_node = queue.delete_at(0) 
      curr_node.children.each do |child|
        if child.color == white
          child.color = gray
          child.parent = curr_node
          child.distance = curr_node.distance + 1
          queue << child
        end
      end
      curr_node.color = black
    end
  end

  def dfs
    clear_params(true)
    time = 0
    self.each_key do |key|
      if self[key].color == white
        dfs_visit(self[key], time)
      end
    end
  end
  
  def print_shortest_path(start_id, end_id)
    bfs(start_id)
    if start_id == end_id
      puts start_id
      return
    end
    if self[end_id].parent.nil?
      puts "there is no path to #{end_id}" 
      return
    end
    print_shortest_path(start_id, self[end_id].parent.data[:id])
    puts end_id
  end
  
  def count_loops_and_cross_edges
    clear_params(true)
    time = 0
    self.each_key do |key|
      if self[key].color == white
        dfs_visit(self[key], time, true)
      end
    end
    {loops: @loops, cross_edges: @cross_edges}
  end

  protected

  def clear_params(has_f_distance = false)
    self.each_key do |key| 
      self[key].clear_node
    end
  end

  def dfs_visit(node, time, find_loop_back_edges = false)
    time += 1 
    node.distance = time 
    node.color = gray
    node.children.each do |child|
      if child.color == white
        child.parent = node
        dfs_visit(child, time)
      elsif find_loop_back_edges
        if child.color == gray
          @loops = @loops.nil? ? 1 : @loops + 1
        elsif child.color == black
          @cross_edges = @cross_edges.nil? ? 1 : @cross_edges + 1
        end
      end
    end
    node.color = black
    time += 1
    node.f_distance = time 
  end

  def create_pinterest_user_graph(max_total_nodes = nil)
    file = File.read('pinterest_users.json')
    data_json = JSON.parse(file)
    max_total_nodes = max_total_nodes || data_json.size 
    nodes_hash = {}

    # my graph is a hash:
    #   key: user_id
    #   value: user_node_object
    #
    #   user_childre: followings  and they point to other nodes in the hash
    #
    #   also followers are kind of like parents they have an edge from themselves to the node
    #   but at this point I'm not doing anythign with them, since if they've been craewled they
    #   would have the current_node as their children, and if they have not been crawled we can't 
    #   make a node out of them
    #


    # put all the nodes in nodes_hash for future
    data_json[0...max_total_nodes].each do |data|
      node =  GraphNode.new({id: data["user_id"], slug: data["user_name"], following: data["following"] }) 
      nodes_hash[data["user_id"]] = node
    end

    # create the graph
    nodes_hash.each_key do |key|
      node = nodes_hash[key]
      self[key] = node 
      node.data[:following].each do |fing_id| 
        node.children << nodes_hash[fing_id] if nodes_hash[fing_id]
      end
    end
  end

  def gray
    'gray'
  end

  def white
    'white'
  end

  def black
    'black'
  end
end

g = Graph.new
g.insert_pinterest_users(500)
#g.bfs(788870756)
#g.dfs
#g.print_shortest_path(788870756, 415148244)
puts g.count_loops_and_cross_edges
