# Ogr

[![Build Status](https://travis-ci.org/knife/ogr.svg?branch=master)](https://travis-ci.org/knife/ogr)

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

To not have to type "Ogr::" before each class, use:

```ruby
  include Ogr
  graph = Graph.new
```


## Graph

Creating new Graph

First define edges:

```ruby
  edges = []
  edges << Edge.new('Jim','Bob')
  edges << Edge.new('Jim','Tom')
  edges << Edge.new('Bob','Jack')
  edges << Edge.new('Tom','Bob')
```
or

```ruby
  edges = [
      ['Jim','Bob'],
      ['Jim','Tom'],
      ['Bob','Jack'],
      ['Tom','Bob']
  ]
```

New undirected graph (implemented as adjency list)

```ruby
  graph = Graph.new(edges)
```

New undirected dense graph (implemented as triangular matrix)

```ruby
  graph = Graph.create(edges)
```
or

```ruby
  graph = Graph.new(edges, :tri_matrix)

```

Examples:
```ruby
  graph.vertex_size #=> 4
  graph.degree("Bob") #=> 3
  graph.edge?("Bob", "Tom") #=> true
  graph.edge?("Tom", "Jack") #=> false
  graph.add_edge(Edge.new("Bob", "Kate"))
  graph.remove("Bob", "Jack")
  graph.neighbors('Tom') #=> ["Bob", "Jim"]
```

Iterating

```ruby
  graph.each_edge{ |e| p e }
  graph.each_vertex{ |v| p v }
```


## Digraph

Directed Weighted Graph

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

New directed graph (implemented as adjency list)

```ruby
  wdigraph = Digraph.new(edges)
```

New directed dense graph (implemented as matrix)
```ruby
  wdigraph = Digraph.create(edges)
```
or
```ruby
  wdigraph = Digraph.new(edges, :matrix)
```

Examples
```ruby
  wdigraph.get_edge(:D, :C).weight #=> 11
  wdigraph.degree(:E) #=> 4
  wdigraph.in_degree(:E) #=> 3
  wdigraph.out_degree(:E) #=> 1
```

## Searching

Breadth First Search:
```ruby
  BreadthFirstSearch.new(wdigraph).search(:A) #=> [:A, :C, :D, :G, :E, :F, :B]
```

Depth First Search:
```ruby
  DepthFirstSearch.new(wdigraph).search(:A) #=> [:A, :G, :B, :E, :D, :C, :F]
```
      
You can also pass block to search methods:
```ruby
  DepthFirstSearch.new(wdigraph).search(:A) { |v| v.upcase }
```

If source vertex is not given search iterates over all vertexes in graph.

## Topological Sort
```ruby
  TopologicalSort.new(graph).sort #=> array of vertexes in topological order
```

## Connected Compontents

```ruby
  cc = ConnectedComponents.new(graph)
  cc.count # => 1
  cc.connected?(:a, :b) # => true
```

## Minimal Spanning Tree

```ruby
  tree = MinimumSpanningTree.new(graph).calculate #=> array of edges
```


## Shortest Paths

Finding shortest paths in graph from vertex 0:
```ruby
  sp = ShortestPaths.new(graph, 0)
  sp.distance_to(7) #=>  returns shortest distance from vertex 0 to vertex 7
  sp.has_path?(7) #=>  returns true if shortest path to 7 exists
  sp.path_to(4) #=>  returns path from vertex 0 to vertex 4
```


