module Ogr
  # Graph class
  class Graph
    # Create new graph from array of edges. Second parameter determines
    # graph internal implementation: :list (Adjency List), :tri_matrix (Triangular
    # Matrix), :matrix (Matrix).
    def initialize(edges = nil, store = :list)
      @map = IndexedSet.new
      case store
      when :list
        @g = GraphAsList.new(directed: false)
      when :matrix
        @g = GraphAsMatrix.new
      when :tri_matrix
        @g = GraphAsTriMatrix.new
      end

      add_edges(edges) if edges
    end

    # Create new graph from array of edges. Internally graph will be represented
    # by Triangular Matrix.
    def self.new_dense(edges)
      new(edges, :tri_matrix)
    end

    # Adds new edge to graph.
    def add(x, y, weight = 1)
      weight ||= 1
      @g.add(push(x), push(y), weight)
    end

    # Adds new edges to graph.
    def add_edges(edges)
      if edges[0].is_a? Array
        edges.each { |e| add(e[0], e[1], e[2]) }
      else
        edges.each { |e| add(e.from, e.to, e.weight) }
      end
    end

    # Adds new edge to graph.
    def add_edge(edge)
      add_edges([edge])
    end

    # Removes connection between vertex x and y.
    def remove(x, y)
      @g.remove(index(x), index(y))
    end

    # Returns all neighbors for given vertex.
    def neighbors(x)
      @g.neighbors(index(x)).map { |i| vertexes[i] }
    end

    # Returns vertex degree.
    def degree(x)
      @g.degree index(x)
    end

    # Checks if two elements are connected.
    def edge?(x, y)
      @g.edge?(index(x), index(y))
    end

    # Returns Edge(x,y) if exist.
    def get_edge(x, y)
      return nil unless edge?(x, y)
      w = @g.get_edge(index(x), index(y))
      Edge.new(x, y, w) if w
    end

    # Vertex iterator
    def each_vertex
      vc.each { |v| yield vertexes[v] }
    end

    # Edge iterator
    def each_edge(&block)
      @g.each_edge(vertexes, &block)
    end

    def vc
      (0...vertexes.size)
    end

    def vertexes
      @map.to_a
    end

    def vertex_size
      vertexes.size
    end

    def edges
      arr = []
      each_edge { |e| arr << e }
      arr
    end

    # Internal numeric representation of vertex
    def index(x)
      @map.index(x)
    end

    private

    def push(x)
      @map.push(x)
    end
  end
end
