module Ogr
  # Class implements Depth First Search in graphs
  class DepthFirstSearch
    attr_accessor :visited, :marked
    attr_reader :graph
    private :graph, :visited=, :marked=

    def initialize(graph)
      @graph = graph
      @marked = {}
      @visited = []
    end

    def search(source = nil, &block)
      if source
        dfs(source, &block)
      else
        graph.vertexes.each { |v| dfs(v, &block) unless marked[v] }
      end
      visited
    end

    private

    def dfs(v, &block)
      @stack = [v]
      while u = @stack.pop
        visit(u, v, &block)
      end
    end

    def visit(v, _from = nil)
      return if marked[v]
      visited << (block_given? ? yield(v) : v)
      marked[v] = true
      @stack.push(*graph.neighbors(v))
    end
  end
end
