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
    end

    it '#connected? returns true if two vertexes are connected.' do
      cc = ConnectedComponents.new(@graph)
      assert cc.connected?(:a, :b)
      assert cc.connected?(:b, :a)
      assert cc.connected?(:a, :c)
      assert cc.connected?(:c, :a)
      assert cc.connected?(:c, :b)
      assert cc.connected?(:e, :d)
      refute cc.connected?(:a, :e)
      refute cc.connected?(:e, :f)
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
    end

    it '#connected? returns true if two vertexes are connected.' do
      cc = ConnectedComponents.new(@graph)
      assert cc.connected?(:a, :b)
      assert cc.connected?(:b, :a)
      assert cc.connected?(:a, :c)
      assert cc.connected?(:c, :a)
      assert cc.connected?(:c, :b)
      assert cc.connected?(:e, :d)
      refute cc.connected?(:a, :e)
      refute cc.connected?(:e, :f)
    end
  end
end
