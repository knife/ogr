require 'test_helper'

describe 'Topological Sort' do
  before do
    edges = [
      [0, 1],
      [0, 5],
      [0, 2],
      [1, 4],
      [3, 5],
      [3, 2],
      [3, 4],
      [3, 6],
      [5, 2],
      [6, 4],
      [6, 0]
    ]
    @graph = Digraph.new(edges)
  end

  it '#sort sorts graph vertexes in topological order.' do
    sorted = TopologicalSort.new(@graph).sort
    sorted.must_equal [3, 6, 0, 1, 4, 5, 2]
  end
end
