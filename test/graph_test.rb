require 'test_helper'

describe Ogr::Graph do
  before do
    @edges = [
      %w(Lukas Marc),
      %w(Lukas Tom),
      %w(Marc Jack),
      %w(Tom Marc)
    ]
  end

  describe 'dense graph implement as Triangular Matrix' do
    before do
      @graph = Graph.new_dense(@edges)
    end

    it '#vertex_size returns number of vertexes' do
      @graph.vertex_size.must_equal 4
    end

    it '#degree returns degree for given vertex.' do
      @graph.degree('Marc').must_equal 3
      @graph.degree('Jack').must_equal 1
      @graph.degree('Lukas').must_equal 2
      @graph.degree('Tom').must_equal 2
    end

    it '#edge? checks if given vertexes are connected.' do
      assert @graph.edge?('Marc', 'Tom')
      assert @graph.edge?('Tom', 'Marc')
      refute @graph.edge?('Tom', 'Jack')
      refute @graph.edge?('Jack', 'Tom')
    end

    it '#add_edges adds new edges.' do
      @graph.add_edges([Edge.new('Marc', 'Kate')])
      @graph.vertex_size.must_equal 5
      assert @graph.edge?('Marc', 'Kate')
      assert @graph.edge?('Kate', 'Marc')
      refute @graph.edge?('Tom', 'Kate')
    end

    it '#add adds new edge to graph.' do
      @graph.add('Jack', 'Lukas')
      @graph.vertex_size.must_equal 4
      assert @graph.edge?('Jack', 'Lukas')
      assert @graph.edge?('Lukas', 'Jack')
    end

    it '#remove_edge removes edge from graph.' do
      @graph.remove('Marc', 'Jack')
      @graph.vertex_size.must_equal 4
      refute @graph.edge?('Marc', 'Jack')
      refute @graph.edge?('Jack', 'Marc')
    end

    it '#neighbors should return all neighbors for given vertex.' do
      n = @graph.neighbors('Tom')
      n.must_be_instance_of Array
      n.size.must_equal 2
      assert n.include?('Marc')
      assert n.include?('Lukas')
      refute n.include?('Jack')
    end

    it '#each_edge iterates over edges.' do
      r = []
      @graph.each_edge { |e| r.push e }
      r.size.must_equal 4
    end

    it '#each_vertex iterates over vertexes.' do
      r = []
      @graph.each_vertex { |v| r.push v }
      r.size.must_equal 4
      r.sort.must_equal %w(Jack Lukas Marc Tom)
    end

    it '#edges returns edges list' do
      @graph.edges.size.must_equal 4
      @graph.edges.must_be_kind_of Array
    end
  end

  describe 'graph implement as Adjency List' do
    before do
      @graph = Graph.new(@edges)
    end

    it '#vertex_size should return number of vertexes' do
      @graph.vertex_size.must_equal 4
    end

    it '#degree should return degree for given vertex.' do
      @graph.degree('Marc').must_equal 3
      @graph.degree('Jack').must_equal 1
      @graph.degree('Lukas').must_equal 2
      @graph.degree('Tom').must_equal 2
    end

    it '#edge? should check if given vertexes are connected.' do
      assert @graph.edge?('Marc', 'Tom')
      # assert @graph.edge?('Tom', 'Marc')
      # refute @graph.edge?('Tom', 'Jack')
      # refute @graph.edge?('Jack', 'Tom')
    end

    it '#add_edges should add new edges.' do
      @graph.add_edges([Edge.new('Marc', 'Kate')])
      @graph.vertex_size.must_equal 5
      assert @graph.edge?('Marc', 'Kate')
      assert @graph.edge?('Kate', 'Marc')
      refute @graph.edge?('Tom', 'Kate')
    end

    it '#add should add new edge to graph.' do
      @graph.add('Jack', 'Lukas')
      @graph.vertex_size.must_equal 4
      assert @graph.edge?('Jack', 'Lukas')
      assert @graph.edge?('Lukas', 'Jack')
    end

    it '#remove_edge should remove edge.' do
      @graph.remove('Marc', 'Jack')
      @graph.vertex_size.must_equal 4
      refute @graph.edge?('Marc', 'Jack')
      refute @graph.edge?('Jack', 'Marc')
    end

    it '#neighbors should return all neighbors for given vertex.' do
      n = @graph.neighbors('Tom')
      n.must_be_instance_of Array
      n.size.must_equal 2
      assert n.include?('Marc')
      assert n.include?('Lukas')
      refute n.include?('Jack')
    end

    it '#each_edge should iterate edges.' do
      r = []
      @graph.each_edge { |e| r.push e }
      r.size.must_equal 4
    end

    it '#each_vertex should iterate vertexes.' do
      r = []
      @graph.each_vertex { |v| r.push v }
      r.size.must_equal 4
      r.sort.must_equal %w(Jack Lukas Marc Tom)
    end

    it '#edges returns edges list' do
      @graph.edges.size.must_equal 4
      @graph.edges.must_be_kind_of Array
    end
  end
end
