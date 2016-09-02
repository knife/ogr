require 'test_helper'

describe 'Graph searching' do
  describe 'with weighted edges' do
    before do
      edges = []

      edges << Edge.new(:a, :c, 5)
      edges << Edge.new(:a, :d, 3)
      edges << Edge.new(:a, :g, 14)
      edges << Edge.new(:c, :e, 3)
      edges << Edge.new(:c, :f, 2)
      edges << Edge.new(:d, :c, 11)
      edges << Edge.new(:d, :e, 7)
      edges << Edge.new(:d, :g, 6)
      edges << Edge.new(:g, :e, 7)
      edges << Edge.new(:e, :b, 5)
      edges << Edge.new(:g, :b, 6)
      edges << Edge.new(:f, :b, 7)

      @wdigraph = Digraph.new_dense(edges)
    end

    it '#bfs should iterate over graph in bfs order.' do
      searcher = BreadthFirstSearch.new(@wdigraph)
      searcher.search(:a).must_equal %i(a c d g e f b)

      searcher.search(:a) { |e| e.to_s.swapcase }
      searcher.visited.must_equal %w(A C D G E F B)
      searcher.distance.must_equal a: 0, c: 1, d: 1, g: 1, e: 2, f: 2, b: 2
      searcher.parents.must_equal a: nil, c: :a, d: :a, g: :a, e: :c, f: :c, b: :g
    end

    it '#dfs should iterate over graph in dfs order.' do
      searcher = DepthFirstSearch.new(@wdigraph)
      searcher.search(:a).must_equal %i(a g b e d c f)

      searcher.search(:a) { |e| e.to_s.swapcase }
      searcher.visited.must_equal %w(A G B E D C F)
      searcher.parents.must_equal a: nil, c: :d, d: :a, g: :a, e: :g, f: :c, b: :g
    end
  end
end
