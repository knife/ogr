$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ogr'
include Ogr

require 'minitest/autorun'
require 'minitest/benchmark' if ENV['BENCH']
