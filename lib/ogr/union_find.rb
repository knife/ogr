module Ogr
  # Class implements Union Find algorithm
  class UnionFind
    attr_reader :store, :sizes
    private :store, :sizes

    def initialize(n)
      @store = (0..n).to_a
      @sizes = [1] * n
    end

    def connected?(x, y)
      root(x) == root(y)
    end

    def union(x, y)
      root_x = root(x)
      root_y = root(y)
      if sizes[root_y] > sizes[root_x]
        store[root_x] = root_y
        sizes[root_y] += sizes[root_x]
      else
        store[root_y] = root_x
        sizes[root_x] += sizes[root_y]
      end
    end

    private

    def root(x)
      parent = store[x]
      parent = store[parent] while parent != store[parent]
      parent
    end
  end
end
