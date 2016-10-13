require 'test_helper'
require 'csv'

if ENV['BENCH'] == 'true'
  describe 'Digraph Benchmark' do
    before :all do
      @edges = CSV.read('test/data/sp.txt', col_sep: ' ')
      @digraph = Digraph.new(@edges.map { |e| [e[0], e[1]] })
    end

    bench_performance_constant '#neighbors should be const op', 0.9 do |n|
      n.times do |i|
        @digraph.neighbors(@edges[n + i][0])
      end
    end

    bench_performance_constant '#neighbors should be const op', 0.9 do |n|
      n.times do |i|
        @digraph.neighbors(@edges[n + i][0])
      end
    end

    bench_performance_constant '#edge? should be const op', 0.9 do |n|
      n.times do |i|
        @digraph.edge?(@edges[n + i][0], @edges[n + i][1])
      end
    end

    bench_performance_constant '#get_edge should be const op', 0.9 do |n|
      n.times do |i|
        @digraph.get_edge(@edges[n + i][0], @edges[n + i][1])
      end
    end

    bench_performance_constant '#remove should be const op', 0.9 do |n|
      n.times do |i|
        @digraph.remove(@edges[n + i][0], @edges[n + i][1])
      end
    end
  end
end
