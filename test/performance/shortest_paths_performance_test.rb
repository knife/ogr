require 'test_helper'
require 'csv'

if ENV['BENCH'] == 'true'
  describe 'ShortestPaths Benchmark' do
    before :all do
      @edges = CSV.read('test/data/sp.txt', col_sep: ' ')
    end

    bench_performance_linear '#finding paths should be linear op', 0.9 do |n|
      edges = @edges.first(n)
      source = edges[0][0].to_i
      @digraph = Digraph.new(edges.map { |e| [e[0].to_i, e[1].to_i, e[2].to_f] })
      ShortestPaths.new(@digraph, source)
    end
  end
end
