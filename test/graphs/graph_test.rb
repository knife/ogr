require 'test_helper'

describe Ogr::Graph do
  before do
    @edges = [
      %w(Lukas Jerry),
      %w(Lukas Tom),
      %w(Jerry Jack),
      %w(Tom Jerry)
    ]
  end

  describe 'implemented as Triangular Matrix' do
    before do
      @graph = Graph.new_dense(@edges)
    end

    it '#vertex_size returns number of vertexes' do
      @graph.vertex_size.must_equal 4
    end

    it '#degree returns degree for given vertex.' do
      @graph.degree('Jerry').must_equal 3
      @graph.degree('Jack').must_equal 1
      @graph.degree('Lukas').must_equal 2
      @graph.degree('Tom').must_equal 2
    end

    it '#edge? checks if given vertexes are connected.' do
      @graph.edge?('Jerry', 'Tom').must_equal true
      @graph.edge?('Tom', 'Jerry').must_equal true
      @graph.edge?('Tom', 'Jack').must_equal false
      @graph.edge?('Jack', 'Tom').must_equal false
    end

    it '#add_edges adds new edges.' do
      @graph.add_edges([Edge.new('Jerry', 'Kate')])
      @graph.vertex_size.must_equal 5
      @graph.edge?('Jerry', 'Kate').must_equal true
      @graph.edge?('Kate', 'Jerry').must_equal true
      @graph.edge?('Tom', 'Kate').must_equal false
    end

    it '#add creates new edge in graph.' do
      @graph.add('Jack', 'Lukas')
      @graph.vertex_size.must_equal 4
      assert @graph.edge?('Jack', 'Lukas')
      assert @graph.edge?('Lukas', 'Jack')
    end

    it '#remove removes edge from graph.' do
      @graph.remove('Jerry', 'Jack')
      @graph.vertex_size.must_equal 4
      refute @graph.edge?('Jerry', 'Jack')
      refute @graph.edge?('Jack', 'Jerry')
    end

    it '#neighbors returns all neighbors for given vertex.' do
      n = @graph.neighbors('Tom')
      n.must_be_instance_of Array
      n.size.must_equal 2
      assert n.include?('Jerry')
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
      r.sort.must_equal %w(Jack Jerry Lukas Tom)
    end

    it '#edges returns edges list' do
      @graph.edges.size.must_equal 4
      @graph.edges.must_be_kind_of Array
    end
  end

  describe 'implemented as Adjency List' do
    before do
      @graph = Graph.new(@edges)
    end

    it '#vertex_size should return number of vertexes' do
      @graph.vertex_size.must_equal 4
    end

    it '#degree should return degree for given vertex.' do
      @graph.degree('Jerry').must_equal 3
      @graph.degree('Jack').must_equal 1
      @graph.degree('Lukas').must_equal 2
      @graph.degree('Tom').must_equal 2
    end

    it '#edge? should check if given vertexes are connected.' do
      assert @graph.edge?('Jerry', 'Tom')
      assert @graph.edge?('Tom', 'Jerry')
      refute @graph.edge?('Tom', 'Jack')
      refute @graph.edge?('Jack', 'Tom')
    end

    it '#add_edges should add new edges.' do
      @graph.add_edges([Edge.new('Jerry', 'Kate')])
      @graph.vertex_size.must_equal 5
      assert @graph.edge?('Jerry', 'Kate')
      assert @graph.edge?('Kate', 'Jerry')
      refute @graph.edge?('Tom', 'Kate')
    end

    it '#add should add new edge to graph.' do
      @graph.add('Jack', 'Lukas')
      @graph.vertex_size.must_equal 4
      assert @graph.edge?('Jack', 'Lukas')
      assert @graph.edge?('Lukas', 'Jack')
    end

    it '#remove_edge should remove edge.' do
      @graph.remove('Jerry', 'Jack')
      @graph.vertex_size.must_equal 4
      refute @graph.edge?('Jerry', 'Jack')
      refute @graph.edge?('Jack', 'Jerry')
    end

    it '#neighbors should return all neighbors for given vertex.' do
      n = @graph.neighbors('Tom')
      n.must_be_instance_of Array
      n.size.must_equal 2
      assert n.include?('Jerry')
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
      r.sort.must_equal %w(Jack Jerry Lukas Tom)
    end

    it '#edges returns edges list' do
      @graph.edges.size.must_equal 4
      @graph.edges.must_be_kind_of Array
    end
  end
end
