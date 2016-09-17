module Ogr
  # Class implements Breadth First Search in graphs
  class BreadthFirstSearch
    attr_accessor :parents, :visited, :distance
    private :parents=, :visited=, :distance=

    def initialize(graph)
      @graph = graph
      @colors = {}
      @parents = {}
      @visited = []
      @distance = {}
      @to_visit = SimpleQueue.new
    end

    def search(s)
      # TODO: Check if source exists in graph
      reset!
      visit_source(s)
      until to_visit.empty?
        v = to_visit.dequeue
        visit_neighbors(v)
        colors[v] = :black
        visited << (block_given? ? yield(v) : v)
      end
      visited
    end

    private

    attr_accessor :graph, :to_visit, :colors

    def reset!
      self.visited = []
      graph.each_vertex do |v|
        colors[v] = :white
        parents[v] = nil
        distance[v] = Float::INFINITY
      end
    end

    def visit_source(s)
      colors[s] = :white
      parents[s] = nil
      distance[s] = 0
      to_visit.enqueue s
    end

    def visit_node(v, from)
      colors[v] = :grey
      parents[v] = from
      distance[v] = distance[from] + 1
      to_visit.enqueue v
    end

    def visit_neighbors(u)
      graph.neighbors(u).each do |v|
        visit_node(v, u) if not_visited?(v)
      end
    end

    def not_visited?(v)
      colors[v] == :white
    end
  end
end
