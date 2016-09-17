require 'ds'

require 'ogr/version'

require 'ogr/graphs/edge'
require 'ogr/graphs/graph_as_matrix'
require 'ogr/graphs/graph_as_list'
require 'ogr/graphs/graph_as_tri_matrix'
require 'ogr/graphs/edge_bag'
require 'ogr/graphs/graph'
require 'ogr/graphs/digraph'
require 'ogr/graphs/breadth_first_search'
require 'ogr/graphs/depth_first_search'
require 'ogr/graphs/connected_components'
require 'ogr/graphs/minimum_spanning_tree'
require 'ogr/union_find'

# Main module namespace
module Ogr
  include DS
end
