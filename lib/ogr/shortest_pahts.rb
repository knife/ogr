module Ogr
  # Finds shortest paths in graph using Dijkstra algorithm
  class ShortestPaths
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

    private

    attr_accessor :parent, :distance, :graph, :queue

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
      if new_distance < distance[edge.to]
        distance[edge.to] = new_distance
        parent[edge.to] = edge.from
        update_queue(edge, new_distance)
      end
    end

    def update_queue(edge, new_distance)
      if queue.include?(edge.to)
        queue.update(edge.to, new_distance)
      else
        queue.push(edge.to, new_distance)
      end
    end
  end
end
