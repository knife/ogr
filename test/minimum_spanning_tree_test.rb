require 'test_helper'

describe 'Minimum Spanning Tree' do
  before do
    edges = [
      [0, 7, 0.16],
      [2, 3, 0.17],
      [1, 7, 0.19],
      [0, 2, 0.26],
      [5, 7, 0.28],
      [1, 3, 0.29],
      [1, 5, 0.32],
      [2, 7, 0.34],
      [4, 5, 0.35],
      [1, 2, 0.36],
      [4, 7, 0.37],
      [0, 4, 0.38],
      [6, 2, 0.40],
      [3, 6, 0.52],
      [6, 0, 0.58],
      [6, 4, 0.93]
    ]
    graph = Graph.new(edges)
    @mst = MinimumSpanningTree.new(graph)
  end

  it '#calculate returns MST for given tree' do
    tree = @mst.calculate
    assert_equal tree.map(&:weight), [0.16, 0.17, 0.19, 0.26, 0.28, 0.35, 0.40]
  end
end
