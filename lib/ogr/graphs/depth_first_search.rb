module Ogr
  # Class implements Breadth First Search in graphs
  class DepthFirstSearch
    attr_accessor :parents, :visited, :distance, :marked
    private :parents=, :visited=, :distance=, :marked=

    def initialize(graph)
      @graph = graph
      @parents = {}
      @marked = {}
      @visited = []
      @distance = {}
    end

    def search(u, &block)
      reset!
      dfs(u, &block)
      visited
    end

    def dfs(v, from = nil, &block)
      marked[v] = true
      visited << (block_given? ? yield(v) : v)
      parents[v] = from
      graph.neighbors(v).reverse_each do |u|
        dfs(u, v, &block) unless marked[u]
      end
    end

    private

    attr_reader :graph

    def reset!
      self.visited = []
      self.parents = {}
      self.marked = {}
    end
  end
end
