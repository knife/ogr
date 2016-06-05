# Ogr

Sparse, dense, directed, undirected, weighted graphs for Ruby.

## Installation

  gem install ogr

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

```ruby
  edges = []
  edges << Edge.new('Jim','Bob')
  edges << Edge.new('Jim','Tom')
  edges << Edge.new('Bob','Jack')
  edges << Edge.new('Tom','Bob')
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

Breadth First Search:
```ruby
  BreadthFirstSearch.new(wdigraph).search(:A) #=> [:A, :C, :D, :G, :E, :F, :B]
```

