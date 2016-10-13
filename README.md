# Ogr

[![Build Status](https://travis-ci.org/knife/ogr.svg?branch=master)](https://travis-ci.org/knife/ogr)
[![Code Climate](https://codeclimate.com/github/knife/ogr/badges/gpa.svg)](https://codeclimate.com/github/knife/ogr)

General graph library for Ruby. Provides sparse(or dense), directed(or undirected) and weighted(or normal) graphs. 
Graph processing algorithms like BFS, DFS, ShortestPaths, MinimumSpanningTree are also included. 
This gem depends only on [DS Gem](https://github.com/knife/ds) which contains other data structures
not implemented in Ruby Standard Library.

## Installation

```ruby
  gem install ogr
```

## Usage

```ruby
  require 'ogr'
  graph = Ogr::Graph.new
```

To not have to type "Ogr::" before each class:

```ruby
  include Ogr
  graph = Graph.new
```


## Graph

Creating new Graph is easy.

First define edges(weights are optional):

```ruby
  edges = []
  edges << Edge.new('Jim','Bob', 12)
  edges << Edge.new('Jim','Tom', 3)
  edges << Edge.new('Bob','Jack', 8)
  edges << Edge.new('Tom','Bob', 5)
```
or

```ruby
  edges = [
      ['Jim','Bob', 12],
      ['Jim','Tom', 3],
      ['Bob','Jack', 8],
      ['Tom','Bob', 5]
  ]
```

Next create new graph:

```ruby
  graph = Graph.new(edges)
```

By default graphs are implemented as adjacency lists. This implementation works in most situations.
However, sometimes triangular matrix may be better choice for internal graph representation (for e.g. dense graphs).
You can set graph internal representation by passing second argument to initializer or using special constructor.

```ruby
  graph = Graph.new_dense(edges)
```
or

```ruby
  graph = Graph.new(edges, :tri_matrix)
```


### Graph API

Some methods defined on graph object:

* degree
* edge?
* add_edge
* add_edges
* get_edge
* vertex_size
* remove
* add
* neighbors
* vertexes
* edges

Examples:

```ruby
  graph.vertex_size #=> 4
  graph.degree("Bob") #=> 3
  graph.edge?("Bob", "Tom") #=> true
  graph.edge?("Tom", "Jack") #=> false
  graph.add_edge(Edge.new("Bob", "Kate"))
  graph.remove("Bob", "Jack")
  graph.neighbors('Tom') #=> ["Bob", "Jim"]
  graph.add("Bob", "Jack")
```

Iterators:

```ruby
  graph.each_edge { |e| p e }
  graph.each_vertex { |v| p v }
```


## Digraph

Digraph (Directed Graph) is graph with directed edges.

Creating new directed graph (implemented as adjacency list):

```ruby
  edges = []
  edges << Edge.new(:A, :C, 5)
  edges << Edge.new(:A, :D, 3)
  edges << Edge.new(:A, :G, 14)
  edges << Edge.new(:C, :E, 3)
  edges << Edge.new(:C, :F, 2)
  edges << Edge.new(:D, :C, 11)
  edges << Edge.new(:D, :E, 7)
  edges << Edge.new(:D, :G, 6)
  edges << Edge.new(:G, :E, 7)
  edges << Edge.new(:E, :B, 5)
  edges << Edge.new(:G, :B, 6)
  edges << Edge.new(:F, :B, 7)
```

```ruby
  digraph = Digraph.new(edges)
```

New directed dense graph (implemented as matrix):
```ruby
  digraph = Digraph.new_dense(edges)
```
or
```ruby
  digraph = Digraph.new(edges, :matrix)
```

### Digraph API

Digraph inherits from Graph so all methods defined in Graph are available.
Digraph defines some additional methods specific to directed graphs:

* in_degree
* out_degree

Examples
```ruby
  digraph.get_edge(:D, :C).weight #=> 11
  digraph.degree(:E) #=> 4
  digraph.in_degree(:E) #=> 3
  digraph.out_degree(:E) #=> 1
```

## Searching

Breadth First Search:
```ruby
  BreadthFirstSearch.new(digraph).search(:A) #=> [:A, :C, :D, :G, :E, :F, :B]
```

Depth First Search:
```ruby
  DepthFirstSearch.new(digraph).search(:A) #=> [:A, :G, :B, :E, :D, :C, :F]
```
      
You can also pass block to search methods:
```ruby
  DepthFirstSearch.new(digraph).search(:A) { |v| v.to_s.downcase }
```

If source vertex is not given, search method iterates over all vertexes in graph.

## Topological Sort

Topological Sort sorts vertexes in topological order (all edges in graph points in the same direction).
Works only for digraphs without cycles (Directed Acyclic Graphs)

```ruby
  TopologicalSort.new(graph).sort #=> array of vertexes in topological order
```

## Connected Compontents

ConnectedComponents finds all connected components in graph.

```ruby
  cc = ConnectedComponents.new(graph)
  cc.count # => 1
  cc.connected?(:a, :b) # => true
```

## Minimum Spanning Tree

MinimumSpanningTree finds tree connecting all vertexes in graph with minimal weights.
Implements Kruskal's algorithm.

```ruby
  tree = MinimumSpanningTree.new(graph).calculate #=> array of edges
```


## Shortest Paths

Finds shortest paths from source to all vertexes in graph. Implements Dijkstra's algorithm and
works only for digraphs with positive weights.

Finding shortest paths in graph from vertex 0:
```ruby
  sp = ShortestPaths.new(digraph, 0)
  sp.distance_to(7) #=>  returns shortest distance from vertex 0 to vertex 7
  sp.has_path?(7) #=>  returns true if shortest path to 7 exists
  sp.path_to(4) #=>  returns path from vertex 0 to vertex 4 (array of vertexes)
```


