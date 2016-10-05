module Ogr
  # Class implements Breadth First Search in graphs
  class BreadthFirstSearch
    attr_accessor :parents, :visited, :distance
    private :parents=, :visited=, :distance=

    def initialize(graph)
      @graph = graph
      @colors = Hash.new(:white)
      @parents = {}
      @visited = []
      @distance = Hash.new(Float::INFINITY)
      @to_visit = SimpleQueue.new
    end

    def search(source = nil, &block)
      if source
        visit_source(source, &block)
      else
        graph.each_vertex { |v| visit_source(v, &block) unless visited?(v) }
      end
      visited
    end

    private

    attr_accessor :graph, :to_visit, :colors

    def visit_source(s)
      distance[s] = 0
      to_visit.enqueue s
      until to_visit.empty?
        v = to_visit.dequeue
        visit_neighbors(v)
        colors[v] = :black
        visited << (block_given? ? yield(v) : v)
      end
    end

    def visit_neighbors(u)
      graph.neighbors(u).each do |v|
        visit_node(v, u) unless visited?(v)
      end
    end

    def visit_node(v, from)
      colors[v] = :grey
      parents[v] = from
      distance[v] = distance[from] + 1
      to_visit.enqueue v
    end

    def visited?(v)
      colors[v] != :white
    end
  end
end
