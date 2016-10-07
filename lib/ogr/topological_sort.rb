module Ogr
  # Sorts graph vertexes in topological order
  class TopologicalSort
    attr_reader :graph, :sorted, :marked
    private :graph, :sorted, :marked

    def initialize(graph)
      @graph = graph
      @marked = {}
      @sorted = []
    end

    def sort
      graph.vertexes.each { |v| dfs(v) unless marked[v] }
      sorted.reverse
    end

    private

    def dfs(v)
      marked[v] = true
      graph.neighbors(v).reverse_each do |u|
        dfs(u) unless marked[u]
      end
      sorted.push v
    end
  end
end
