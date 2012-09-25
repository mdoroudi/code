require 'debugger'
require 'colorize'

class GraphNode
  attr_accessor :data, :children, :params

  def initialize(node_data = nil, params = {})
    @data = node_data
    @params = {
      color: 'white',
      distance: Float::INFINITY,
      parent: nil,
    }
    @params = @params.merge(params)
    @children = []
  end

  def color
    @params[:color]
  end

  def color=(value)
    @params[:color] = value
  end

  def distance
    @params[:distance]
  end

  def distance=(value)
    @params[:distance] = value
  end 

  def parent
    @params[:parent]
  end

  def parent=(value)
    @params[:parent] = value
  end

  def clear_node(has_f_distance = false)
    color = 'white'
    distance = Float::INFINITY
    parent = nil
    f_distance = Float::INFINITY if has_f_distance 
  end

  # only for DFS
  def f_distance
    @params[:f_distance]
  end

  def f_distance=(value)
    @params[:f_distance] = value
  end
end

