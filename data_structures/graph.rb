require 'debugger'
require 'colorize'

def node
  attr_accessor :data, :left, :right, :params

  def initialize(node_data = nil)
    @data = node_data
  end
end

def bfs(graph, s)
  
end
