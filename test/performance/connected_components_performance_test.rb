require 'test_helper'
require 'csv'

if ENV['BENCH'] == 'true'
  describe 'ConnectedComponents Benchmark' do
    before :all do
      @edges = CSV.read('test/data/edges.csv')
    end

    bench_performance_linear '#calculating connected components should be linear op', 0.9 do |n|
      edges = @edges.first(n)
      @digraph = Digraph.new(edges.map { |e| [e[0], e[1]] })
      ConnectedComponents.new(@digraph)
    end
  end
end
