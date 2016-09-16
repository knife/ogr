require 'test_helper'

describe 'UnionFind' do
    before do
      @uf = UnionFind.new(10)
    end

    it '#union connects two vertexes.' do
      @uf.union(5,2)
      assert @uf.connected?(5,2)
      assert @uf.connected?(2,5)
      refute @uf.connected?(5,3)
    end
end
