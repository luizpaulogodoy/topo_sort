require_relative '../lib/graph.rb'

describe Graph do

  let(:graph) {
    Graph.new(
      [
        [0, 3],
        [3, 5],
        [5, 7],
        [5, 6],
        [1, 2],
        [2, 6],
        [4, 6],
        [6, 7]
      ]
    )
  }

  describe "#base" do
    it "gets first element of edge" do
      expect(graph.send(:base, [0, 3])).to eq(0)
    end
  end

  describe "#destination" do
    it "gets last element of edge" do
      expect(graph.send(:destination, [0, 3])).to eq(3)
    end
  end

  describe "#next_nodes" do
    it "gets next nodes" do
      expect(graph.next_nodes(5)).to include([5, 7], [5, 6])
    end
  end

  describe "#predecessors" do
    it "gets predecessors nodes" do
      expect(graph.predecessors(7)).to include([5, 7], [6, 7])
    end
  end

  describe "#sort" do
    it "returns empty nodes" do
      empty_graph = Graph.new([])
      expect(empty_graph.sort).to eq([])
    end

    it "sorts the nodes of graph" do
      tidy = [0, 1, 4, 3, 2, 5, 6, 7]
      expect(graph.sort).to eq(tidy)
    end

    it "gets error when has cyclic graph" do
      cyclic_graph = Graph.new([[3, 5], [5, 3]])
      expect { cyclic_graph.sort }.to raise_error(CyclicError)
    end
  end
end
