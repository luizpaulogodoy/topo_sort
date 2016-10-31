CyclicError = Class.new(StandardError)
class Graph
  attr_reader :edges, :nodes

  def initialize(edges, nodes=[])
    @edges = edges
    @nodes = (nodes + edges.flatten).uniq
  end

  def next_nodes(node)
    edges.select {|i| node == base(i)}
  end

  def predecessors(node)
    edges.select {|i| node == destination(i)}
  end

  def sort
    if nodes.empty?
      []
    else
      first_nodes = nodes.select {|n| predecessors(n).empty?}
      if first_nodes.empty?
        raise CyclicError
      end
      removed_edges = first_nodes.map {|n| next_nodes(n)}.flatten(1)
      unsorted_nodes = Graph.new(edges - removed_edges, nodes - first_nodes)
      first_nodes + unsorted_nodes.sort
    end
  end

  private

  def base(edge)
    edge.first
  end

  def destination(edge)
    edge.last
  end

end
