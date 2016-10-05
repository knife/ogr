require 'test_helper'
require 'csv'

if ENV['BENCH']
  describe 'MinimumSpanningTree Benchmark' do
    before :all do
      @edges = CSV.read('test/data/10000EWG.txt', col_sep: ' ')
    end

    bench_performance_linear '#calculating mst should be linear', 0.9 do |n|
      edges = @edges.first(n)
      @graph = Graph.new(edges.map { |e| [e[0], e[1], 1] })
      MinimumSpanningTree.new(@graph).calculate
    end
  end
end
