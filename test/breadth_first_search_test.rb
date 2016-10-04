require 'test_helper'

describe 'BreadthFirstSearch' do
  describe 'for Digraph with weighted edges' do
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
      @searcher = BreadthFirstSearch.new(@wdigraph)
    end

    it '#search iterates in bfs order.' do
      @searcher.search(:a).must_equal %i(a c d g e f b)
      @searcher.distance.must_equal a: 0, c: 1, d: 1, g: 1, e: 2, f: 2, b: 2
    end

    it '#search yields block in bfs order.' do
      @searcher.search(:a) { |e| e.to_s.swapcase }
      @searcher.visited.must_equal %w(A C D G E F B)
    end
  end

  describe 'for not connected graph' do
    before do
      edges = []
      edges << Edge.new(:a, :c)
      edges << Edge.new(:a, :d)
      edges << Edge.new(:a, :g)
      edges << Edge.new(:e, :b)
      edges << Edge.new(:f, :b)
      @graph = Graph.new(edges)
    end

    describe 'when source vertex not given' do
      before do
        @searcher = BreadthFirstSearch.new(@graph)
      end

      it '#search iterates in bfs order over all vertexes.' do
        @searcher.search.sort.must_equal %i(a b c d e f g)
      end
    end
  end
end
