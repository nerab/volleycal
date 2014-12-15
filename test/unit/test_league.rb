# -*- encoding: utf-8 -*-
require 'helper'

class TestLeague < Volleycal::TestCase
  include Volleycal

  def test_find_one
    league = League.lookup(8750636)
    refute_nil(league)
    assert_equal('1. Bundesliga Frauen', league.title)
  end

  def test_find_none
    assert_raises(UnknownLeague) do
      League.lookup(875063)
    end
  end

  def test_find_nil
    assert_raises(UnknownLeague) do
      League.lookup(nil)
    end
  end

  def test_find_string
    assert_raises(UnknownLeague) do
      League.lookup('')
    end
  end
end
