module Ogr
  # ConnectedComponents class
  class ConnectedComponents
    attr_accessor :visited
    attr_reader :graph
    private :graph, :visited, :visited=

    def initialize(graph)
      @graph = graph
      @visited = {}

      mark_components
    end

    def connected?(v, u)
      visited[v] == visited[u]
    end

    private

    def mark_components
      self.visited = {}
      marker = 0
      vertexes.each { |v| visited[v] = nil }
      vertexes.each do |v|
        unless visited[v]
          dfs(v, marker)
          marker += 1
        end
      end
    end

    def dfs(v, marker)
      visited[v] = marker
      graph.neighbors(v).reverse_each do |u|
        dfs(u, marker) unless visited[u]
      end
    end

    def vertexes
      @vertexes ||= graph.vertexes
    end
  end
end
