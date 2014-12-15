$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'volleycal'
require 'minitest/autorun'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr'
  c.hook_into :webmock
end

module Volleycal
  class TestCase < MiniTest::Unit::TestCase
    def mocked(cassette = name, &block)
      VCR.use_cassette("#{self.class.name}_#{cassette}", :record => :new_episodes){block.call}
    end
  end
end
