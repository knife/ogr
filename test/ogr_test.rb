require 'test_helper'

class OgrTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ogr::VERSION
  end
end
