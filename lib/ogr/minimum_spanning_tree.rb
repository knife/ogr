module Ogr
  # Class implements Kruskal algorithm for finding Minimum Spanning Tree
  class MinimumSpanningTree
    attr_reader :graph, :uf
    private :graph, :uf

    def initialize(graph)
      @graph = graph
      @uf = UnionFind.new(@graph.vertexes.size)
    end

    def calculate
      tree = []
      while edge = edges.shift
        from = graph.index(edge.from)
        to = graph.index(edge.to)

        unless uf.connected?(from, to)
          uf.union(from, to)
          tree << edge
        end
      end
      tree
    end

    private

    def edges
      @edges ||= @graph.edges.sort_by(&:weight)
    end
  end
end
