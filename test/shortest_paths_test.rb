require 'test_helper'

describe 'Shortest paths' do
  describe 'for weighted graph' do
    before do
      edges = [
        [0, 1, 5.0],
        [0, 4, 9.0],
        [0, 7, 8.0],
        [1, 2, 12.0],
        [1, 3, 15.0],
        [1, 7, 4.0],
        [2, 3, 3.0],
        [2, 6, 11.0],
        [3, 6, 9.0],
        [4, 5, 4.0],
        [4, 6, 20.0],
        [4, 7, 5.0],
        [5, 2, 1.0],
        [5, 6, 13.0],
        [7, 5, 6.0],
        [7, 2, 7.0]
      ]
      graph = Digraph.new(edges)
      @sp = ShortestPaths.new(graph, 0)
    end

    it '#distance_to returns distance from source.' do
      @sp.distance_to(7).must_equal 8.0
      @sp.distance_to(0).must_equal 0.0
      @sp.distance_to(5).must_equal 13.0
      @sp.distance_to(6).must_equal 25.0
      @sp.distance_to(2).must_equal 14.0
    end

    it '#from returns parent of given vertex in path.' do
      @sp.from(4).must_equal 0
      @sp.from(6).must_equal 2
      @sp.from(2).must_equal 5
      @sp.from(5).must_equal 4
      @sp.from(4).must_equal 0
    end

    it '#has_path? returns true if for given vertex exist path from source.' do
      @sp.path?(4).must_equal true
      @sp.path?(6).must_equal true
      @sp.path?(2).must_equal true
      @sp.path?(5).must_equal true
      @sp.path?(4).must_equal true
    end

    it '#path_to returns array of vertexes on shortest path.' do
      @sp.path_to(4).must_be_instance_of Array
      @sp.path_to(4).must_equal [0, 4]
      @sp.path_to(6).must_equal [0, 4, 5, 2, 6]
      @sp.path_to(0).must_equal [0]
    end
  end
end
