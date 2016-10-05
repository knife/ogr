require 'test_helper'
require 'csv'

if ENV['BENCH']
  describe 'Graph Search Benchmark' do
    before :all do
      @edges = CSV.read('test/data/edges.csv')
      @digraph = Digraph.new(@edges.map { |e| [e[0], e[1]] })
    end

    bench_performance_linear '#dfs should be linear op', 0.9 do |n|
      edges = @edges.first(n)
      @digraph = Digraph.new(edges.map { |e| [e[0], e[1]] })
      start = edges[0][0]
      DepthFirstSearch.new(@digraph).search(start)
    end

    bench_performance_linear '#bfs should be linear op', 0.9 do |n|
      edges = @edges.first(n)
      @digraph = Digraph.new(edges.map { |e| [e[0], e[1]] })
      start = edges[0][0]
      BreadthFirstSearch.new(@digraph).search(start)
    end
  end
end
