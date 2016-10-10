module Ogr
  # Finds shortest paths in graph using Dijkstra algorithm
  class ShortestPaths
    attr_reader :parent, :distance, :graph, :queue
    private :parent, :distance, :graph, :queue

    def initialize(graph, source)
      @graph = graph
      @queue = IndexedPriorityQueue.min
      @parent = {}
      @distance = {}
      @graph.vertexes.each { |v| @distance[v] = Float::INFINITY }

      find_paths(source)
    end

    def distance_to(goal)
      distance[goal]
    end

    def from(goal)
      parent[goal]
    end

    def path?(goal)
      distance[goal] < Float::INFINITY
    end

    def path_to(goal)
      v = goal
      path = [v]
      path.push v while v = parent[v]
      path.reverse
    end

    def find_paths(source)
      distance[source] = 0
      queue.push(source, 0)

      while v = queue.shift
        graph.neighbors(v).each do |u|
          relax(graph.get_edge(v, u))
        end
      end
    end

    def relax(edge)
      new_distance = distance[edge.from] + edge.weight
      found_better(edge, new_distance) if new_distance < distance[edge.to]
    end

    def found_better(edge, new_distance)
      v = edge.to
      distance[v] = new_distance
      parent[v] = edge.from
      if queue.include?(v)
        queue.update(v, new_distance)
      else
        queue.push(v, new_distance)
      end
    end
  end
end
