CyclicError = Class.new(StandardError)
class Graph
  attr_reader :edges, :nodes

  def initialize(edges, nodes=[])
    @edges = edges
    @nodes = (nodes + edges.flatten).uniq
  end

  def successors(node)
    edges.select {|i| node == base(i)}
  end

  def predecessors(node)
    edges.select {|i| node == destination(i)}
  end

  def sort
    return [] if nodes.empty?

    first_nodes = nodes.select {|n| predecessors(n).empty?}
    raise CyclicError if first_nodes.empty?

    removed_edges = first_nodes.map {|n| successors(n)}.flatten(1)
    unsorted_nodes = Graph.new(edges - removed_edges, nodes - first_nodes)

    first_nodes + unsorted_nodes.sort
  end

  private

  def base(edge)
    edge.first
  end

  def destination(edge)
    edge.last
  end

end
