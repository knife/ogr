require 'test_helper'
require 'csv'

if ENV['BENCH']
  describe 'Digraph Benchmark' do
    before :all do
      edges = CSV.read('test/data/edges.csv')
      @digraph = Digraph.new(edges.map { |e| [e[0], e[1]] })
    end

    bench_performance_constant '#edge? should be const op', 0.999 do |n|
      n.times do
        @digraph.edge?('1', '98676')
      end
    end

    bench_performance_constant '#get_edge should be const op', 0.999 do |n|
      n.times do
        @digraph.get_edge('1', '98676')
      end
    end

    bench_performance_constant '#remove should be const op', 0.999 do |n|
      edges = CSV.read('test/data/edges.csv')
      n.times do |i|
        @digraph.remove(edges[n + i][0], edges[n + i][1])
      end
    end
  end
end
