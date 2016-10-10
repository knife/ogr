module Ogr
  # ConnectedComponents class finds graph components
  class ConnectedComponents
    attr_reader :graph, :visited, :counter, :stack
    private :graph, :visited, :counter, :stack

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

    def components
      visited
    end

    def count
      counter
    end

    private

    def find_components
      vertexes.each do |v|
        unless visited[v]
          dfs(v)
          @counter += 1
        end
      end
    end

    def dfs(v)
      @stack = [v]
      while u = stack.pop
        visit(u)
      end
    end

    def visit(v)
      return if visited[v]
      visited[v] = counter
      stack.concat(graph.neighbors(v))
    end

    def vertexes
      @vertexes ||= graph.vertexes
    end
  end
end
