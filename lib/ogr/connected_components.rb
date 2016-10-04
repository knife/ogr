module Ogr
  # ConnectedComponents class finds graph components
  class ConnectedComponents
    attr_accessor :visited, :counter
    attr_reader :graph
    private :graph, :visited, :visited=, :counter, :counter=

    def initialize(graph)
      @graph = graph
      @visited = {}
      @counter = 0
      find_components
    end

    def connected?(v, u)
      visited[v] == visited[u]
    end

    def component(v)
      visited[v]
    end

    def count
      counter
    end

    private

    def find_components
      vertexes.each do |v|
        unless visited[v]
          dfs(v, counter)
          @counter += 1
        end
      end
    end

    def dfs(v, counter)
      visited[v] = counter
      graph.neighbors(v).reverse_each do |u|
        dfs(u, counter) unless visited[u]
      end
    end

    def vertexes
      @vertexes ||= graph.vertexes
    end
  end
end
