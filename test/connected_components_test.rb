require 'test_helper'

describe 'Connected components' do
  describe 'for normal graph' do
    before do
      edges = [
        %i(a b),
        %i(b c),
        %i(c a),
        %i(d e),
        %i(f g)
      ]
      @graph = Graph.new(edges)
      @cc = ConnectedComponents.new(@graph)
    end

    it '#connected? returns true if two vertexes are connected.' do
      @cc.connected?(:a, :b).must_equal true
      @cc.connected?(:b, :a).must_equal true
      @cc.connected?(:a, :c).must_equal true
      @cc.connected?(:c, :a).must_equal true
      @cc.connected?(:c, :b).must_equal true
      @cc.connected?(:e, :d).must_equal true
      @cc.connected?(:a, :e).must_equal false
      @cc.connected?(:e, :f).must_equal false
    end

    it '#counter returns number of connected components.' do
      @cc.count.must_equal 3
    end

    it '#component returns component number for given vertex.' do
      @cc.component(:a).must_equal 0
      @cc.component(:b).must_equal 0
      @cc.component(:d).must_equal 1
      @cc.component(:f).must_equal 2
    end
  end

  describe 'for directed graph' do
    before do
      edges = [
        %i(a b),
        %i(b c),
        %i(c a),
        %i(d e),
        %i(f g)
      ]
      @graph = Digraph.new(edges)
      @cc = ConnectedComponents.new(@graph)
    end

    it '#connected? returns true if two vertexes are connected.' do
      @cc.connected?(:a, :b).must_equal true
      @cc.connected?(:b, :a).must_equal true
      @cc.connected?(:a, :c).must_equal true
      @cc.connected?(:c, :a).must_equal true
      @cc.connected?(:c, :b).must_equal true
      @cc.connected?(:e, :d).must_equal true
      @cc.connected?(:a, :e).must_equal false
      @cc.connected?(:e, :f).must_equal false
    end

    it '#counter returns number of connected components.' do
      @cc.count.must_equal 3
    end

    it '#component returns component number for given vertex.' do
      @cc.component(:a).must_equal 0
      @cc.component(:b).must_equal 0
      @cc.component(:d).must_equal 1
      @cc.component(:f).must_equal 2
    end

    it '#components returns hash with components.' do
      @cc.components.must_be_instance_of Hash
      @cc.components.size.must_equal 7
      @cc.components[:b].must_equal 0
    end
  end
end
